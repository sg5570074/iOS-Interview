//
//  StarRatingView.swift
//  RottenMovies
//
//  Displays star rating with half-star support
//

import SwiftUI

struct StarRatingView: View {
	let rating: Double
	let maxRating: Double = 10
	let starCount: Int = 10  // 10 stars, each represents 1 point

	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			HStack(spacing: 2) {
				ForEach(0..<starCount, id: \.self) { index in
					starImage(for: index)
						.foregroundColor(.appWarning)
						.font(.system(size: 16))
				}
			}

			Text(String(format: "%.1f / 10", rating))
				.font(.system(size: 16, weight: .semibold))
				.foregroundColor(.appTextSecondary)
		}
	}

	private func starImage(for index: Int) -> Image {
		let fillAmount = (rating - Double(index))

		if fillAmount >= 1.0 {
			// Full star
			return Image(systemName: "star.fill")
		} else if fillAmount >= 0.5 {
			// Half star
			return Image(systemName: "star.leadinghalf.filled")
		} else {
			// Empty star
			return Image(systemName: "star")
		}
	}
}

#Preview {
	VStack(spacing: 20) {
		StarRatingView(rating: 8.5)
		StarRatingView(rating: 7.8)
		StarRatingView(rating: 6.3)
		StarRatingView(rating: 9.2)
		StarRatingView(rating: 10.0)
	}
	.padding()
	.background(Color.appBackground)
}
