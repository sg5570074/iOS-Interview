//
//  DetailsViewModel.swift
//  RottenMovies
//
//  Created by Bilsky-Rollins, Simon on 11/1/23.
//

import SwiftUI

@Observable
final class DetailsViewModel {
	var image: UIImage?

	let movie: Movie

	init(movie: Movie) {
		self.movie = movie
	}

	var movieId: Int {
		movie.id
	}

	var title: String {
		movie.title
	}

	var overview: String? {
		movie.overview
	}

	var voteAverage: Double {
        movie.voteAverage ?? 0.0
	}

	@MainActor
	func fetchImage() async {
		guard let url = movie.imageURL else { return }

		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			image = UIImage(data: data)
		} catch {
			return
		}
	}
}
