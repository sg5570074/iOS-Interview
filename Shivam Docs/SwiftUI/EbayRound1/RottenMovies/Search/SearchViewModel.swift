//
//  SearchViewModel.swift
//  RottenMovies
//
//  MVVM ViewModel for Search screen
//

import Foundation

@MainActor
@Observable
final class SearchViewModel {
	var movies: [Movie] = []
	var isLoading = false
	var errorMessage: String?
	var showLikedOnly = false

	private let movieService = MovieService()
	private var likeManager = LikeManager.shared
	private(set) var filteredMovies: [Movie] = []

	func searchMovies(query: String) async {
		guard !query.isEmpty else {
			movies = []
			return
		}

		isLoading = true
		errorMessage = nil

		do {
			let moviesSearched = try await movieService.searchMovies(query: query)
			movies = moviesSearched
		} catch {
			errorMessage = "Search failed: \(error.localizedDescription)"
		}

		isLoading = false
	}

	func applyLikeFilter() {
		guard showLikedOnly else {
			filteredMovies = movies
			return
		}

		filteredMovies = movies.filter { likeManager.isLiked($0) }
	}
}
