//
//  HomeViewModel.swift
//  RottenMovies
//
//  MVVM ViewModel for Home screen
//

import Foundation
import Observation

@MainActor
@Observable
final class HomeViewModel {
	var movies: [Movie] = []
	var isLoading = false
	var errorMessage: String?

	private let movieService = MovieService()
	private var likeManager = LikeManager.shared

	init(likeManager: LikeManager = LikeManager.shared) {
		self.likeManager = likeManager
	}

	func fetchMovies() async {
		isLoading = true
		errorMessage = nil

		likeManager.loadLikes()
       // print("Before\(Thread.isMainThread)")
		do {
			movies = try await movieService.fetchPopularMovies()
		} catch {
			errorMessage = "Failed to load movies: \(error)"
		}
        isLoading = false
      //  print("After\(Thread.isMainThread)")
	}
}
