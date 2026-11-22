//
//  MovieService.swift
//  RottenMovies
//
//  Unified service layer with async/await
//

import Foundation
import os

enum MovieServiceError: Error {
	case invalidURL
	case invalidResponse
	case decodingError(_ message: String)
}

extension MovieServiceError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .invalidURL:
			return "Invalid URL"
		case .invalidResponse:
			return "Invalid response from server"
		case .decodingError(let message):
			return "Failed to decode movies: \(message)"
		}
	}
}

/// API Documentation: https://developer.themoviedb.org/reference/discover-movie
final class MovieService {
	private let urlSession: URLSession
	private let logger = os.Logger(subsystem: "com.rottenMovies.app", category: "MovieService")

	init(urlSession: URLSession = .shared) {
		self.urlSession = urlSession
	}

	func fetchPopularMovies() async throws -> [Movie] {
		guard let url = makePopularMoviesURL() else {
			throw MovieServiceError.invalidURL
		}

		let (data, response) = try await urlSession.data(from: url)

		guard let httpResponse = response as? HTTPURLResponse,
			  httpResponse.statusCode == 200 else {
			throw MovieServiceError.invalidResponse
		}

		do {
			let moviesResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
			return moviesResponse.results
		} catch {
			let message = logAndExtractErrorMessage(from: error)
			throw MovieServiceError.decodingError(message)
		}
	}

	func searchMovies(query: String) async throws -> [Movie] {
		guard let url = makeSearchMoviesURL(query: query) else {
			throw MovieServiceError.invalidURL
		}

		let (data, response) = try await urlSession.data(from: url)

		guard let httpResponse = response as? HTTPURLResponse,
			  httpResponse.statusCode == 200 else {
			throw MovieServiceError.invalidResponse
		}

		do {
			let moviesResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
			return moviesResponse.results
		} catch {
			let message = logAndExtractErrorMessage(from: error)
			throw MovieServiceError.decodingError(message)
		}
	}

	// MARK: - Private Helpers

	private func logAndExtractErrorMessage(from error: Error) -> String {
		if let decodingError = error as? DecodingError,
		   case .dataCorrupted(let context) = decodingError,
		   let underlyingError = context.underlyingError {
			logger.error("Failed to decode movies: \(underlyingError)")
			return "\(underlyingError)"
		} else {
			logger.error("Failed to decode movies: \(error.localizedDescription)")
			return error.localizedDescription
		}
	}

	// MARK: - Private URL Builders

	private func makePopularMoviesURL() -> URL? {
		URL(string: API.baseURL + API.discoverPath + "?" + API.apiKey + "&" + API.popularOrder)
	}

	private func makeSearchMoviesURL(query: String) -> URL? {
		let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
		return URL(string: API.baseURL + API.searchPath + "?" + API.apiKey + "&" + API.searchQuery + encodedQuery)
	}
}
