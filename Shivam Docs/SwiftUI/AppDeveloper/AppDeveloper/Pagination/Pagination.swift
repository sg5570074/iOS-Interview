//
//  Pagination.swift
//  AppDeveloper
//
//  Created by Shivam on 09/05/26.
//

import Foundation
import Combine
import SwiftUI

// MARK: - DataModel
struct FeedItem: Identifiable, Codable {
    let id: Int
    let title: String
}



// MARK: - Service
protocol FeedServiceProtocol {
    func fetchFeed(page: Int, limit: Int) async throws -> [FeedItem]
}

final class FeedService: FeedServiceProtocol {

    func fetchFeed(page: Int, limit: Int) async throws -> [FeedItem] {

        try await Task.sleep(nanoseconds: 1_000_000_000)

        let start = (page - 1) * limit

        return (1...limit).map {
            FeedItem(
                id: start + $0,
                title: "Feed Item \(start + $0)"
            )
        }
    }
}


//MARK: - ViewModel


@MainActor
final class FeedViewModel: ObservableObject {

    @Published var items: [FeedItem] = []
    @Published var isLoading = false

    private let service: FeedServiceProtocol

    private var currentPage = 1
    private let pageSize = 20
    private var hasMorePages = true

    init(service: FeedServiceProtocol = FeedService()) {
        self.service = service
    }

    func loadInitialFeed() async {
        guard items.isEmpty else { return }
        await fetchFeed()
    }

    func loadMoreIfNeeded(currentItem item: FeedItem) async {

        guard let lastItem = items.last else {
            await fetchFeed()
            return
        }

        // Trigger when user reaches last 5 items
        let thresholdIndex = items.index(items.endIndex, offsetBy: -5)

        if items[thresholdIndex].id == item.id {
            await fetchFeed()
        }
    }

    private func fetchFeed() async {

        guard !isLoading, hasMorePages else { return }

        isLoading = true

        do {
            let newItems = try await service.fetchFeed(
                page: currentPage,
                limit: pageSize
            )

            items.append(contentsOf: newItems)

            currentPage += 1

            // If API returns fewer items than limit,
            // assume last page
            if newItems.count < pageSize {
                hasMorePages = false
            }

        } catch {
            print("Error: \(error)")
        }

        isLoading = false
    }
}


// MARK: - SwiftUI View


struct FeedPaginationView: View {

    @StateObject private var viewModel = FeedViewModel()

    var body: some View {

        NavigationView {

            ScrollView {

                LazyVStack(spacing: 16) {

                    ForEach(viewModel.items) { item in

                        FeedRow(item: item)
                            .onAppear {

                                Task {
                                    await viewModel.loadMoreIfNeeded(
                                        currentItem: item
                                    )
                                }
                            }
                    }

                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    }
                }
                .padding()
            }
            .navigationTitle("Instagram Feed")
            .task {
                await viewModel.loadInitialFeed()
            }
            .refreshable {
                await viewModel.loadInitialFeed()
            }
        }
    }
}



struct FeedRow: View {

    let item: FeedItem

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 250)
                .cornerRadius(12)

            Text(item.title)
                .font(.headline)

            Text("This is a sample Instagram/Facebook style post.")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 2)
    }
}
