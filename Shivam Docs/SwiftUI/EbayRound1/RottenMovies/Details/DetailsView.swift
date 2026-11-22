//
//  DetailsView.swift
//  RottenMovies
//
//  Created by Bilsky-Rollins, Simon on 11/1/23.
//

import SwiftUI

struct DetailsView: View {
	@State var viewModel: DetailsViewModel
	@State private var likeManager = LikeManager.shared
	
	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 20) {
				image

				VStack(alignment: .leading, spacing: 12) {
					HStack {
						title
						Spacer()
						likeButton
					}
					rating
				}

				overview
			}
			.padding(20)
		}
		.background(Color.appBackground)
		.onAppear {
			Task {
				await viewModel.fetchImage()
			}

			likeManager.loadLikes()
		}
	}

	@ViewBuilder var image: some View {
		if let image = viewModel.image {
			Image(uiImage: image)
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(maxWidth: .infinity)
				.frame(height: 400)
				.clipShape(RoundedRectangle(cornerRadius: 20))
				.shadow(color: .appShadow, radius: 12, x: 0, y: 6)
		} else {
			ZStack {
				RoundedRectangle(cornerRadius: 20)
					.fill(Color.appTextSecondary.opacity(0.1))
					.frame(height: 400)

				ProgressView()
					.scaleEffect(1.5)
					.tint(.appAccent)
			}
		}
	}

	var title: some View {
		Text(viewModel.title)
			.font(.system(size: 28, weight: .bold))
			.foregroundColor(.appText)
	}

	@ViewBuilder var rating: some View {
		StarRatingView(rating: Double(viewModel.voteAverage))
	}

	@ViewBuilder var overview: some View {
		if let overview = viewModel.overview {
			VStack(alignment: .leading, spacing: 8) {
				Text("Overview")
					.font(.system(size: 18, weight: .semibold))
					.foregroundColor(.appText)

				Text(overview)
					.font(.body)
					.foregroundColor(.appTextSecondary)
					.padding(16)
					.background(Color.appSecondary.opacity(0.1))
					.cornerRadius(16)
			}
		}
	}

	var likeButton: some View {
		Button(action: {
			likeManager.toggleLike(viewModel.movie)
		}) {
			Image(systemName: likeManager.isLiked(viewModel.movie) ? "heart.fill" : "heart")
				.font(.system(size: 28))
				.foregroundColor(likeManager.isLiked(viewModel.movie) ? .appAccent : .appTextSecondary)
		}
	}
}
