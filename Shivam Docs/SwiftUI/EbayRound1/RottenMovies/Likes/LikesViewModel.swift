//
//  LikesViewModel.swift
//  RottenMovies
//
//  MVVM ViewModel for Likes screen
//

import Foundation

@MainActor
@Observable
final class LikesViewModel {
	var likedMovies: [Movie] = []
	var likesManager: LikeManagerProtocol

	// TODO: FEATURE #1: Implement LikesViewModel feature
	init(likesManager: LikeManagerProtocol = LikeManager.shared) {
		self.likesManager = likesManager
        likedMovies = likesManager.likedMovies
	}

    func loadNewLikedMoview() {
        likedMovies = likesManager.likedMovies
    }
}
