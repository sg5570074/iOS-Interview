//
//  HomeView.swift
//  RottenMovies
//
//  SwiftUI Home screen with MVVM
//

import SwiftUI

struct HomeView: View {
	@State private var viewModel = HomeViewModel()

	var body: some View {
		NavigationStack {
			ZStack {
				Color.appBackground.ignoresSafeArea()

				ScrollView {
					LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
						ForEach(viewModel.movies) { movie in
							NavigationLink(value: movie) {
								MovieCardView(movie: movie)
							}
							.buttonStyle(PlainButtonStyle())
						}
					}
					.padding(16)
				}
				.navigationTitle("Popular Movies")
				.navigationDestination(for: Movie.self) { movie in
					DetailsView(viewModel: DetailsViewModel(movie: movie))
				}
                
				if viewModel.isLoading {
					VStack(spacing: 16) {
						ProgressView()
							.scaleEffect(1.5)
							.tint(.appAccent)
						Text("Loading movies...")
							.font(.headline)
							.foregroundColor(.appText)
					}
					.padding(32)
					.background(
						RoundedRectangle(cornerRadius: 16)
							.fill(Color.white)
							.shadow(color: .appShadow, radius: 20)
					)
				}

				if let errorMessage = viewModel.errorMessage {
					VStack(spacing: 12) {
						Image(systemName: "exclamationmark.triangle.fill")
							.font(.system(size: 50))
							.foregroundColor(.appWarning)
						Text("Error")
							.font(.title2)
							.fontWeight(.bold)
							.foregroundColor(.appText)
						Text(errorMessage)
							.font(.body)
							.foregroundColor(.appTextSecondary)
							.multilineTextAlignment(.center)
							.padding(.horizontal)
					}
					.padding(32)
					.background(
						RoundedRectangle(cornerRadius: 16)
							.fill(Color.white)
							.shadow(color: .appShadow, radius: 20)
					)
					.padding()
				}
			}
			.task {
				await viewModel.fetchMovies()
            }
		}
		.refreshable {
			await viewModel.fetchMovies()
		}
	}
}
