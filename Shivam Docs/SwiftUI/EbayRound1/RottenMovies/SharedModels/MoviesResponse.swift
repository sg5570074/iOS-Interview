//
//  MoviesResponse.swift
//  RottenMovies
//
//  API Response wrapper for movie lists
//

import Foundation

/// API Documentation: https://developer.themoviedb.org/reference/discover-movie
struct MoviesResponse: Codable {
	let results: [Movie]
}
