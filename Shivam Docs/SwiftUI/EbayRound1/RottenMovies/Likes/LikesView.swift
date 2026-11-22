//
//  LikesView.swift
//  RottenMovies
//
//  SwiftUI Likes screen showing all liked movies
//

import SwiftUI

struct LikesView: View {
	@State private var viewModel = LikesViewModel()

	var body: some View {
		NavigationStack {
			ZStack {
				Color.appBackground.ignoresSafeArea()

				if viewModel.likedMovies.isEmpty {
					// Empty state
					VStack(spacing: 16) {
						Image(systemName: "heart.slash")
							.font(.system(size: 60))
							.foregroundColor(.appTextSecondary)
						Text("No Liked Movies Yet")
							.font(.title3)
							.fontWeight(.semibold)
							.foregroundColor(.appText)
						Text("Like movies to see them here")
							.font(.body)
							.foregroundColor(.appTextSecondary)
					}
					.padding()
				} else {
					ScrollView {
						LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
							ForEach(viewModel.likedMovies) { movie in
								NavigationLink(value: movie) {
									MovieCardView(movie: movie)
								}
								.buttonStyle(PlainButtonStyle())
							}
						}
						.padding(16)
					}
					.navigationDestination(for: Movie.self) { movie in
						DetailsView(viewModel: DetailsViewModel(movie: movie))
					}
				}
			}
            .onChange(of: viewModel.likesManager.likedMovies) { oldValue, newValue in
                viewModel.loadNewLikedMoview()
            }
			.navigationTitle("Liked Movies")
            .onAppear {
                viewModel.loadNewLikedMoview()
            }

		}
	}
}
