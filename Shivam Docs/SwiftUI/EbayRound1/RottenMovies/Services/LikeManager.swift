//
//  LikeManager.swift
//  RottenMovies
//
//  Manages movie likes using UserDefaults
//

import Foundation

protocol LikeManagerProtocol {
	var likedMovies: [Movie] { get }
	func loadLikes()
	func isLiked(_ movie: Movie) -> Bool
	func toggleLike(_ movieId: Movie)
}

@Observable
final class LikeManager: LikeManagerProtocol {
	static let shared = LikeManager()

	private(set) var likedMovies: [Movie] = []
	private let userDefaults: UserDefaults
	private let likedMoviesKey = "likedMovies"

	init(userDefaults: UserDefaults = .standard) {
		self.userDefaults = userDefaults
	}

	func loadLikes() {
		if let data = userDefaults.data(forKey: likedMoviesKey),
		   let decoded = try? JSONDecoder().decode([Movie].self, from: data) {
			likedMovies = decoded
		}
	}

	func isLiked(_ movie: Movie) -> Bool {
		likedMovies.contains(movie)
	}

	func toggleLike(_ movie: Movie) {
		if likedMovies.contains(movie) {
			likedMovies.removeAll(where: { $0 == movie })
		} else {
			likedMovies.append(movie)
		}

        do {
          let endcodedMovies = try JSONEncoder().encode(likedMovies)
            userDefaults.set(endcodedMovies, forKey: likedMoviesKey)
        } catch {}
	}
}
