//
//  MovieCardView.swift
//  RottenMovies
//
//  Reusable movie card for grids
//

import SwiftUI

struct MovieCardView: View {
	let movie: Movie
	@State private var likeManager = LikeManager.shared
	
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			ZStack(alignment: .topTrailing) {
				AsyncImage(url: movie.imageURL) { image in
					image
						.resizable()
						.aspectRatio(contentMode: .fill)
				} placeholder: {
					ZStack {
						Color.appTextSecondary.opacity(0.1)
						Image(systemName: "film")
							.font(.system(size: 40))
							.foregroundColor(.appTextSecondary.opacity(0.3))
					}
				}
				.frame(height: 240)
				.clipShape(RoundedRectangle(cornerRadius: 12))

				// Like button - tappable and updates reactively
				Button(action: {
					likeManager.toggleLike(movie)
				}) {
					Image(systemName: likeManager.isLiked(movie) ? "heart.fill" : "heart")
						.font(.system(size: 20))
						.foregroundColor(likeManager.isLiked(movie) ? .appAccent : .white)
						.padding(8)
						.background(
							Circle()
								.fill(Color.black.opacity(0.5))
								.shadow(color: .appShadow, radius: 4)
						)
				}
				.padding(8)
			}

			VStack(alignment: .leading, spacing: 4) {
				Text(movie.title)
					.font(.system(size: 14, weight: .semibold))
					.lineLimit(2)
					.foregroundColor(.appText)

				if let voteAverage = movie.voteAverage {
					HStack(spacing: 4) {
						Image(systemName: "star.fill")
							.font(.system(size: 11))
							.foregroundColor(.appWarning)
						Text(String(format: "%.1f / 10", voteAverage))
							.font(.system(size: 13, weight: .medium))
							.foregroundColor(.appTextSecondary)
					}
				}
			}
			.padding(.horizontal, 8)
			.padding(.bottom, 8)
		}
		.frame(maxWidth: .infinity)
		.background(
			RoundedRectangle(cornerRadius: 16)
				.fill(Color.cardBackground)
		)
		.shadow(color: .appShadow, radius: 8, x: 0, y: 4)
	}
}
