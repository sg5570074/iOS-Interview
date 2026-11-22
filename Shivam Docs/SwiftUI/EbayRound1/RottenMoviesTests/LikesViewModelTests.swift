//
//  LikesViewModelTests.swift
//  RottenMoviesTests
//
//  Tests for LikesViewModel functionality
//

@testable import RottenMovies
import XCTest

@MainActor
final class LikesViewModelTests: XCTestCase {
	var sut: LikesViewModel!
	var mockLikeManager: LikeManager!
	var mockUserDefaults: UserDefaults!

	override func setUp() {
		super.setUp()

		// Use in-memory UserDefaults for testing
		mockUserDefaults = UserDefaults(suiteName: "TestDefaults")!
		mockUserDefaults.removePersistentDomain(forName: "TestDefaults")

		mockLikeManager = LikeManager(userDefaults: mockUserDefaults)
	}

	override func tearDown() {
		sut = nil
		mockLikeManager = nil
		mockUserDefaults.removePersistentDomain(forName: "TestDefaults")
		mockUserDefaults = nil
		super.tearDown()
	}

	// MARK: - Test loadLikedMovies()

	// TODO: Implement test_loadLikedMovies_whenNoLikedMovies_likedMoviesIsEmpty
	func test_loadLikedMovies_whenNoLikedMovies_likedMoviesIsEmpty() async {
		// Given - no liked movies in LikeManager
		sut = LikesViewModel(likesManager: mockLikeManager)

		// When

		// Then

	}

	// TODO: Implement test_loadLikedMovies_whenLikedMoviesExist_loadsMoviesFromLikeManager
	func test_loadLikedMovies_whenLikedMoviesExist_loadsMoviesFromLikeManager() async {
		// Given - some movies are liked
		sut = LikesViewModel(likesManager: mockLikeManager)
		let movie1 = Movie.mock(id: 1, title: "Movie 1")
		let movie2 = Movie.mock(id: 2, title: "Movie 2")

		// When

		// Then

	}

	// MARK: - Test removeLike()

	// TODO: Implement test_removeLike_removesMovieFromLikedMovies
	func test_removeLike_removesMovieFromLikedMovies() async {
		// Given - a movie is liked
		sut = LikesViewModel(likesManager: mockLikeManager)
		let movie = Movie.mock(id: 1, title: "Test Movie")

		// When

		// Then

	}
}
