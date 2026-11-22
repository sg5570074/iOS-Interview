//
//  RottenMoviesApp.swift
//  RottenMovies
//
//  SwiftUI App entry point
//

import SwiftUI

@main
struct RottenMoviesApp: App {
	var body: some Scene {
		WindowGroup {
			TabView {
				HomeView()
					.tabItem {
						Label("Popular Movies", systemImage: "star.fill")
					}

				// TODO: FEATURE #1: Implement Like Tab feature
				LikesView()
					.tabItem {
						Label("Likes", systemImage: "heart.fill")
					}

				SearchView()
					.tabItem {
						Label("Search", systemImage: "magnifyingglass")
					}

			}
			.tint(.appAccent)  // Modern accent color for tab selection
		}
	}
}
