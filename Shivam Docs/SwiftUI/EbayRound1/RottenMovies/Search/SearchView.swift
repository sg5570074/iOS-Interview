//
//  SearchView.swift
//  RottenMovies
//
//  SwiftUI Search screen with MVVM
//

import SwiftUI

struct SearchView: View {
    @State private var viewModel = SearchViewModel()
	@State private var searchText = ""
	@State private var likeManager = LikeManager.shared
	
	var body: some View {
		NavigationStack {
			ZStack {
				Color.appBackground.ignoresSafeArea()

				if viewModel.movies.isEmpty && !searchText.isEmpty && !viewModel.isLoading {
					// Empty state
					VStack(spacing: 16) {
						Image(systemName: "film.stack")
							.font(.system(size: 60))
							.foregroundColor(.appTextSecondary)
						Text("No movies found")
							.font(.title3)
							.fontWeight(.semibold)
							.foregroundColor(.appText)
						Text("Try searching for something else")
							.font(.body)
							.foregroundColor(.appTextSecondary)
					}
					.padding()
				} else if searchText.isEmpty {
					// Prompt state
					VStack(spacing: 16) {
						Image(systemName: "magnifyingglass")
							.font(.system(size: 60))
							.foregroundColor(.appAccent)
						Text("Search for movies")
							.font(.title3)
							.fontWeight(.semibold)
							.foregroundColor(.appText)
						Text("Start typing to find your favorite films")
							.font(.body)
							.foregroundColor(.appTextSecondary)
					}
					.padding()
				} else {
					VStack(spacing: 0) {
						// Filter toggle for liked movies
						HStack {
							Image(systemName: "heart.fill")
								.foregroundColor(.appAccent)
							Text("Show Liked Only")
								.font(.system(size: 15, weight: .medium))
								.foregroundColor(.appText)
							Spacer()
							Toggle("", isOn: $viewModel.showLikedOnly)
								.labelsHidden()
								.tint(.appAccent)
						}
						.padding(.horizontal, 16)
						.padding(.vertical, 12)
						.background(Color.white)
						.shadow(color: .appShadow.opacity(0.1), radius: 2, y: 1)

						ScrollView {
							LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
								ForEach(viewModel.filteredMovies) { movie in
									NavigationLink(value: movie) {
										MovieCardView(movie: movie)
									}
									.buttonStyle(PlainButtonStyle())
								}
							}
							.padding(16)
						}
					}
				}

				// Loading indicator
				if viewModel.isLoading {
					ProgressView()
						.scaleEffect(1.5)
						.tint(.appAccent)
						.padding(32)
						.background(
							RoundedRectangle(cornerRadius: 16)
								.fill(Color.white)
								.shadow(color: .appShadow, radius: 20)
						)
				}
			}
			.navigationTitle("Search")
			.navigationBarTitleDisplayMode(.inline)
			.navigationDestination(for: Movie.self) { movie in
				DetailsView(viewModel: DetailsViewModel(movie: movie))
			}
			.searchable(text: $searchText, prompt: "Search movies...")
			.onChange(of: searchText) { _, newValue in
				Task {
					await viewModel.searchMovies(query: newValue)
					viewModel.applyLikeFilter()
				}
			}
			.task {
				likeManager.loadLikes()
				viewModel.applyLikeFilter()
			}
		}
	}
}
