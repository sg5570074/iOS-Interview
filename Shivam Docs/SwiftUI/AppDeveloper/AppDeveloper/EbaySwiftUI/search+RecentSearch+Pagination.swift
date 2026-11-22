//
//  search+RecentSearch.swift
//  AppDeveloper
//
//  Created by Shivam on 17/05/26.
//



import Foundation
import SwiftUI
import Combine


//MARK: - 📦 MODELS
struct Product1: Identifiable, Codable, Equatable, Hashable {
    let id: String
    let title: String
    let imageURL: String
    let price: String
}

struct SearchResponse: Codable {
    let items: [Product1]
    let nextCursor: String?
}


//MARK: - 🌐 API CLIENT
protocol APIClientProtocol1 {
    func search(
        query: String,
        cursor: String?
    ) async throws -> SearchResponse
}

final class APIClient1: APIClientProtocol1 {

    func search(
        query: String,
        cursor: String?
    ) async throws -> SearchResponse {

        var components = URLComponents(
            string: "https://api.ebay.com/search"
        )!

        components.queryItems = [
            .init(name: "query", value: query)
        ]

        if let cursor {
            components.queryItems?.append(
                .init(name: "cursor", value: cursor)
            )
        }

        let request = URLRequest(url: components.url!)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let response = response as? HTTPURLResponse,
              200..<300 ~= response.statusCode else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(
            SearchResponse.self,
            from: data
        )
    }
}


//MARK: - 💾 RECENT SEARCH STORAGE
protocol RecentSearchStorageProtocol {
    func fetchRecentSearches() -> [String]
    func save(search: String)
}

final class RecentSearchStorage: RecentSearchStorageProtocol {

    private let key = "recent_searches"

    func fetchRecentSearches() -> [String] {
        UserDefaults.standard.stringArray(forKey: key) ?? []
    }

    func save(search: String) {

        var searches = fetchRecentSearches()

        searches.removeAll { $0 == search }

        searches.insert(search, at: 0)

        searches = Array(searches.prefix(10))

        UserDefaults.standard.set(searches, forKey: key)
    }
}

////MARK: - 📚 REPOSITORY
protocol SearchRepositoryProtocol {

    func search(
        query: String,
        cursor: String?
    ) async throws -> SearchResponse

    func fetchRecentSearches() -> [String]

    func saveRecentSearch(_ query: String)
}

final class SearchRepository: SearchRepositoryProtocol {

    private let apiClient: APIClientProtocol1
    private let storage: RecentSearchStorageProtocol

    init(
        apiClient: APIClientProtocol1,
        storage: RecentSearchStorageProtocol
    ) {
        self.apiClient = apiClient
        self.storage = storage
    }

    func search(
        query: String,
        cursor: String?
    ) async throws -> SearchResponse {

        try await apiClient.search(
            query: query,
            cursor: cursor
        )
    }

    func fetchRecentSearches() -> [String] {
        storage.fetchRecentSearches()
    }

    func saveRecentSearch(_ query: String) {
        storage.save(search: query)
    }
}


//MARK: - 🔄 SEARCH STATE

enum SearchState {
    case idle
    case loading
    case loaded
    case empty
    case error(String)
}

//MARK: - 🧠 VIEWMODEL
@MainActor
final class SearchViewModel: ObservableObject {

    @Published var query = ""
    @Published private(set) var products: [Product1] = []
    @Published private(set) var recentSearches: [String] = []
    @Published private(set) var state: SearchState = .idle

    private let repository: SearchRepositoryProtocol

    private var searchTask: Task<Void, Never>?

    private var nextCursor: String?
    private var isLoading = false
    private var hasMorePages = true

    init(repository: SearchRepositoryProtocol) {
        self.repository = repository

        loadRecentSearches()
    }

    func onSearchQueryChanged() {

        searchTask?.cancel()

        searchTask = Task {

            try? await Task.sleep(
                nanoseconds: 500_000_000
            )

            guard !Task.isCancelled else { return }

            await performSearch()
        }
    }

    func performSearch() async {

        guard !query.isEmpty else {
            products = []
            state = .idle
            return
        }

        nextCursor = nil
        hasMorePages = true
        products = []

        repository.saveRecentSearch(query)

        loadRecentSearches()

        await fetchPage()
    }

    func loadMoreIfNeeded(currentItem: Product1) async {

        guard currentItem.id == products.last?.id else {
            return
        }

        guard hasMorePages else { return }

        await fetchPage()
    }

    private func fetchPage() async {

        guard !isLoading else { return }

        isLoading = true

        defer {
            isLoading = false
        }

        state = .loading

        do {

            let response = try await repository.search(
                query: query,
                cursor: nextCursor
            )

            products.append(contentsOf: response.items)

            nextCursor = response.nextCursor

            hasMorePages = response.nextCursor != nil

            state = products.isEmpty
                ? .empty
                : .loaded

        } catch {

            state = .error(error.localizedDescription)
        }
    }

    private func loadRecentSearches() {
        recentSearches = repository.fetchRecentSearches()
    }

    func selectRecentSearch(_ search: String) {

        query = search

        Task {
            await performSearch()
        }
    }
}

//MARK: - 🧭 COORDINATOR

enum SearchRoute: Hashable {
    case productDetail(Product1)
}

protocol SearchCoordinatorProtocol {
    func showProductDetail(product: Product1)
}

@MainActor
final class SearchCoordinator: SearchCoordinatorProtocol, ObservableObject {
    
    @Published var path = NavigationPath()
    
    func showProductDetail(product: Product1) {
        path.append(
            SearchRoute.productDetail(product)
        )
        print("Navigate to:", product.title)
    }
}

//MARK: - 📱 SEARCH VIEW

struct SearchView: View {

    @StateObject private var viewModel: SearchViewModel

    private let coordinator: SearchCoordinatorProtocol

    init(
        viewModel: SearchViewModel,
        coordinator: SearchCoordinatorProtocol
    ) {
        _viewModel = StateObject(
            wrappedValue: viewModel
        )

        self.coordinator = coordinator
    }

    var body: some View {

        NavigationView {

            VStack {

                TextField(
                    "Search products",
                    text: $viewModel.query
                )
                .textFieldStyle(.roundedBorder)
                .padding()
                .onChange(of: viewModel.query) { _ in
                    viewModel.onSearchQueryChanged()
                }

                content
            }
            .navigationTitle("Search")
        }
    }

    @ViewBuilder
    private var content: some View {

        switch viewModel.state {

        case .idle:

            recentSearchesView

        case .loading:

            ProgressView()

        case .empty:

            Text("No Results")

        case .error(let message):

            Text(message)

        case .loaded:

            List(viewModel.products) { product in

                VStack(alignment: .leading) {

                    Text(product.title)

                    Text(product.price)
                        .foregroundColor(.secondary)
                }
                .onTapGesture {
                    coordinator.showProductDetail(
                        product: product
                    )
                }
                .task {
                    await viewModel.loadMoreIfNeeded(
                        currentItem: product
                    )
                }
            }
        }
    }

    private var recentSearchesView: some View {

        List {

            Section("Recent Searches") {

                ForEach(
                    viewModel.recentSearches,
                    id: \.self
                ) { search in

                    Button(search) {
                        viewModel.selectRecentSearch(search)
                    }
                }
            }
        }
    }
}

//MARK: - 💉 DEPENDENCY INJECTION

final class AppDIContainer1 {

    func makeSearchView() -> some View {

        let apiClient = APIClient1()

        let storage = RecentSearchStorage()

        let repository = SearchRepository(
            apiClient: apiClient,
            storage: storage
        )

        let viewModel = SearchViewModel(
            repository: repository
        )

        let coordinator = SearchCoordinator()

        return SearchView(
            viewModel: viewModel,
            coordinator: coordinator
        )
    }
}
