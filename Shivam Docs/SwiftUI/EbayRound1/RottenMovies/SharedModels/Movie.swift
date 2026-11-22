//
//  Movie.swift
//  RottenMovies
//
//  Modernized with Codable
//

import Foundation

/// API Documentation: https://developer.themoviedb.org/reference/discover-movie
struct Movie: Codable, Identifiable, Hashable, Equatable {
	let id: Int
	let title: String
	let overview: String?
	let posterPath: String?
	let voteAverage: Double?
	let imageURL: URL?

	enum CodingKeys: String, CodingKey {
		case id
		case title
		case overview
		case posterPath = "poster_path"
		case voteAverage = "vote_average"
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		id = try container.decode(Int.self, forKey: .id)
		title = try container.decode(String.self, forKey: .title)
		overview = try container.decodeIfPresent(String.self, forKey: .overview)
		voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
		posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)

		// Construct image URL from poster path
		if let posterPath = posterPath {
			imageURL = URL(string: "\(API.imageBaseURL)\(posterPath)?\(API.apiKey)")
		} else {
			imageURL = nil
		}
	}
}
