//
//  ebayDesiign.swift
//  AppDeveloper
//
//  Created by Shivam on 16/05/26.
//


import SwiftUI
import Combine

// MARK: - MODELS

struct Product: Identifiable, Decodable {
    let id: String
    let title: String
    let imageURL: String
    let price: String
}

struct FeedResponse: Decodable {
    let items: [Product]
    let nextCursor: String?
}

// MARK: - NETWORK LAYER

protocol APIClientProtocol {
    func fetchFeed(cursor: String?) async throws -> FeedResponse
}

final class APIClient: APIClientProtocol {

    func fetchFeed(cursor: String?) async throws -> FeedResponse {

        var components = URLComponents(string: "https://api.ebay.com/feed")!

        var queryItems: [URLQueryItem] = []

        if let cursor {
            queryItems.append(.init(name: "cursor", value: cursor))
        }

        components.queryItems = queryItems

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(FeedResponse.self, from: data)
    }
}

// MARK: - REPOSITORY

protocol FeedRepositoryProtocol {
    func fetchFeed(cursor: String?) async throws -> FeedResponse
}

final class FeedRepository: FeedRepositoryProtocol {

    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func fetchFeed(cursor: String?) async throws -> FeedResponse {
        try await apiClient.fetchFeed(cursor: cursor)
    }
}

// MARK: - IMAGE CACHE

protocol ImageCacheProtocol {
    func image(forKey key: NSString) -> UIImage?
    func save(_ image: UIImage, forKey key: NSString)
}

final class ImageCache: ImageCacheProtocol {

    static let shared = ImageCache()

    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    func image(forKey key: NSString) -> UIImage? {
        cache.object(forKey: key)
    }

    func save(_ image: UIImage, forKey key: NSString) {
        cache.setObject(image, forKey: key)
    }
}

// MARK: - IMAGE LOADER

@MainActor
final class ImageLoader: ObservableObject {

    @Published var image: UIImage?

    private let cache: ImageCacheProtocol

    init(cache: ImageCacheProtocol = ImageCache.shared) {
        self.cache = cache
    }

    func load(from urlString: String) async {

        let key = NSString(string: urlString)

        if let cachedImage = cache.image(forKey: key) {
            image = cachedImage
            return
        }

        guard let url = URL(string: urlString) else {
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let downloadedImage = UIImage(data: data) {
                cache.save(downloadedImage, forKey: key)
                image = downloadedImage
            }

        } catch {
            print("Image loading failed:", error)
        }
    }
}

// MARK: - STATE

enum FeedState {
    case idle
    case loading
    case loaded
    case empty
    case error(String)
}

// MARK: - VIEWMODEL

@MainActor
final class DesignFeedViewModel: ObservableObject {

    @Published private(set) var products: [Product] = []
    @Published private(set) var state: FeedState = .idle

    private let repository: FeedRepositoryProtocol

    private var nextCursor: String?
    private var isFetching = false
    private var hasMorePages = true

    init(repository: FeedRepositoryProtocol) {
        self.repository = repository
    }

    func loadInitialFeed() async {

        guard products.isEmpty else { return }

        state = .loading

        await fetchFeed()
    }

    func loadMoreIfNeeded(currentItem: Product) async {

        guard let lastItem = products.last else { return }

        guard lastItem.id == currentItem.id else { return }

        guard hasMorePages else { return }

        await fetchFeed()
    }

    private func fetchFeed() async {

        guard !isFetching else { return }

        isFetching = true

        defer {
            isFetching = false
        }
        state = .loading
        do {

            let response = try await repository.fetchFeed(cursor: nextCursor)

            products.append(contentsOf: response.items)

            nextCursor = response.nextCursor

            hasMorePages = response.nextCursor != nil

            state = products.isEmpty ? .empty : .loaded

        } catch {

            state = .error(error.localizedDescription)
        }
    }

    func retry() async {
        state = .loading
        await fetchFeed()
    }
}

// MARK: - COORDINATOR

protocol FeedCoordinatorProtocol {
    func showProductDetails(product: Product)
}

final class FeedCoordinator: FeedCoordinatorProtocol {

    func showProductDetails(product: Product) {
        print("Navigate to product:", product.title)
    }
}

// MARK: - PRODUCT CARD VIEW

struct ProductCardView: View {

    let product: Product

    @StateObject private var imageLoader = ImageLoader()

    var body: some View {

        HStack(spacing: 12) {

            Group {

                if let image = $imageLoader.image {

                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()

                } else {

                    ProgressView()
                }

            }
            .frame(width: 100, height: 100)
            .clipped()
            .cornerRadius(12)

            VStack(alignment: .leading, spacing: 8) {

                Text(product.title)
                    .font(.headline)

                Text(product.price)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .task {
            await imageLoader.load(from: product.imageURL)
        }
        .padding()
    }
}

// MARK: - FEED VIEW

struct FeedView: View {

    @StateObject private var viewModel: DesignFeedViewModel

    private let coordinator: FeedCoordinatorProtocol

    init(
        viewModel: DesignFeedViewModel,
        coordinator: FeedCoordinatorProtocol
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.coordinator = coordinator
    }

    var body: some View {

        NavigationView {

            content
                .navigationTitle("eBay Feed")
        }
        .task {
            await viewModel.loadInitialFeed()
        }
    }

    @ViewBuilder
    private var content: some View {

        switch viewModel.state {

        case .idle, .loading:

            ProgressView("Loading Feed...")

        case .empty:

            Text("No Products Found")

        case .error(let message):

            VStack(spacing: 16) {

                Text(message)

                Button("Retry") {

                    Task {
                        await viewModel.retry()
                    }
                }
            }

        case .loaded:

            ScrollView {

                LazyVStack {

                    ForEach(viewModel.products) { product in

                        ProductCardView(product: product)
                            .onTapGesture {
                                coordinator.showProductDetails(product: product)
                            }
                            .task {
                                await viewModel.loadMoreIfNeeded(currentItem: product)
                            }
                    }

                    ProgressView()
                        .padding()
                }
            }
        }
    }
}

// MARK: - DEPENDENCY CONTAINER

final class AppDIContainer {

    func makeFeedView() -> some View {

        let apiClient = APIClient()

        let repository = FeedRepository(apiClient: apiClient)

        let viewModel = DesignFeedViewModel(repository: repository)

        let coordinator = FeedCoordinator()

        return FeedView(
            viewModel: viewModel,
            coordinator: coordinator
        )
    }
}

// MARK: - APP ENTRY

@main
struct EbayFeedApp: App {

    private let container = AppDIContainer()

    var body: some Scene {

        WindowGroup {

            container.makeFeedView()
        }
    }
}
