//
//  LikeManagerTests.swift
//  RottenMoviesTests
//
//  Tests for LikeManager persistence and functionality
//

@testable import RottenMovies
import XCTest

// TEST #1: LikeManager Tests
final class LikeManagerTests: XCTestCase {
	var sut: LikeManager!
	var mockUserDefaults: UserDefaults!

	override func setUp() {
		super.setUp()

		// Use in-memory UserDefaults for testing
		mockUserDefaults = UserDefaults(suiteName: "TestDefaults")!
		mockUserDefaults.removePersistentDomain(forName: "TestDefaults")

		sut = LikeManager(userDefaults: mockUserDefaults)
	}

	override func tearDown() {
		sut = nil
		mockUserDefaults.removePersistentDomain(forName: "TestDefaults")
		mockUserDefaults = nil
		super.tearDown()
	}

	// MARK: - Test loadLikes()

	func test_loadLikes_whenNoData_returnsEmptyArray() {
		// When
		sut.loadLikes()

		// Then
		XCTAssertTrue(sut.likedMovies.isEmpty, "Should have no liked movies")
	}

	func test_loadLikes_whenDataExists_loadsMovies() {
		// Given
		let movie = Movie.mock(id: 1, title: "Test Movie")
		let movies = [movie]
		let encoded = try! JSONEncoder().encode(movies)
		mockUserDefaults.set(encoded, forKey: "likedMovies")

		// When
		sut.loadLikes()

		// Then
		XCTAssertEqual(sut.likedMovies.count, 1)
		XCTAssertTrue(sut.likedMovies.contains(movie))
	}

	// MARK: - Test isLiked()

	func test_isLiked_whenMovieNotLiked_returnsFalse() {
		// Given
		let movie = Movie.mock(id: 1, title: "Test Movie")

		// When
		let result = sut.isLiked(movie)

		// Then
		XCTAssertFalse(result)
	}

	func test_isLiked_whenMovieIsLiked_returnsTrue() {
		// Given
		let movie = Movie.mock(id: 1, title: "Test Movie")
		sut.toggleLike(movie)

		// When
		let result = sut.isLiked(movie)

		// Then
		XCTAssertTrue(result)
	}

	// MARK: - Test toggleLike()

	func test_toggleLike_whenNotLiked_addsMovieToLikedMovies() {
		// Given
		let movie = Movie.mock(id: 1, title: "Test Movie")
		XCTAssertFalse(sut.isLiked(movie), "Precondition: movie should not be liked")

		// When
		sut.toggleLike(movie)

		// Then
		XCTAssertTrue(sut.isLiked(movie), "Movie should now be liked")
		XCTAssertEqual(sut.likedMovies.count, 1)
	}

	func test_toggleLike_whenAlreadyLiked_removesMovieFromLikedMovies() {
		// Given
		let movie = Movie.mock(id: 1, title: "Test Movie")
		sut.toggleLike(movie)
		XCTAssertTrue(sut.isLiked(movie), "Precondition: movie should be liked")

		// When
		sut.toggleLike(movie)

		// Then
		XCTAssertFalse(sut.isLiked(movie), "Movie should no longer be liked")
		XCTAssertTrue(sut.likedMovies.isEmpty)
	}

	// MARK: - Test Persistence

	func test_toggleLike_persistsToUserDefaults() {
		// Given
		let movie = Movie.mock(id: 1, title: "Test Movie")

		// When
		sut.toggleLike(movie)

		// Then - Create a new instance to verify persistence
		let newInstance = LikeManager(userDefaults: mockUserDefaults)
		newInstance.loadLikes()

		XCTAssertEqual(newInstance.likedMovies.count, 1,
			"Liked movies should persist to UserDefaults")
		XCTAssertTrue(newInstance.isLiked(movie),
			"Movie should still be liked after creating new LikeManager instance")
	}

	func test_toggleLike_unlikedMovie_removesFromUserDefaults() {
		// Given
		let movie = Movie.mock(id: 1, title: "Test Movie")
		sut.toggleLike(movie)  // Like it first

		// When
		sut.toggleLike(movie)  // Unlike it

		// Then - Create a new instance to verify persistence
		let newInstance = LikeManager(userDefaults: mockUserDefaults)
		newInstance.loadLikes()

		XCTAssertTrue(newInstance.likedMovies.isEmpty,
			"Unliked movie should be removed from UserDefaults")
		XCTAssertFalse(newInstance.isLiked(movie))
	}
}

// MARK: - Test Helpers
extension Movie {
	static func mock(
		id: Int = 1,
		title: String = "Test Movie",
		overview: String? = "Test overview",
		posterPath: String? = "/test.jpg",
		voteAverage: Int? = 8
	) -> Movie {
		// Create JSON data that can be decoded into a Movie
		let json = """
		{
			"id": \(id),
			"title": "\(title)",
			"overview": \(overview.map { "\"\($0)\"" } ?? "null"),
			"poster_path": \(posterPath.map { "\"\($0)\"" } ?? "null"),
			"vote_average": \(voteAverage ?? 0)
		}
		""".data(using: .utf8)!

		return try! JSONDecoder().decode(Movie.self, from: json)
	}
}
