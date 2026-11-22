//
//  MovieDetailsDisplayViewControllerTests.swift
//  PremierSwiftTests
//
//  Created by Shivam Gupta on 11/01/25.
//  Copyright © 2025 Deliveroo. All rights reserved.
//

import XCTest
@testable import PremierSwift

final class MovieDetailsDisplayViewControllerTests: XCTestCase {
    var viewController: MovieDetailsDisplayViewController!

    override func setUp() {
        super.setUp()
        let movieDetails = MockData.movieDetails
        let similarMovies = MockData.similarMovies
        viewController = MovieDetailsDisplayViewController(movieDetails: movieDetails, similarMovies: similarMovies)
        _ = viewController.view
    }

    func testInitialization() {
        let viewController = MovieDetailsDisplayViewController(
            movieDetails: MockData.movieDetails,
            similarMovies: MockData.similarMovies
        )

        XCTAssertEqual(viewController.movieDetails.title, MockData.movieDetails.title)
        XCTAssertEqual(viewController.similairMovies.count, MockData.similarMovies.count)
    }

    func test_viewDidLoad_configuresUI() {
        XCTAssertNotNil(viewController.scrollView)
        XCTAssertNotNil(viewController.backdropImageView)
        XCTAssertNotNil(viewController.titleLabel)
        XCTAssertNotNil(viewController.overviewLabel)
        XCTAssertNotNil(viewController._collectionView)
    }

    func test_configure_updatesUIWithMovieDetails() {
        XCTAssertEqual(viewController.titleLabel.text, MockData.movieDetails.title)
        XCTAssertEqual(viewController.overviewLabel.text, MockData.movieDetails.overview)
    }

    func test_collectionViewLoadsSimilarMovies() {
        let dataSource = viewController._dataSource
        viewController.loadViewIfNeeded()
        guard let snapshot = dataSource?.snapshot() else { return }
        XCTAssertEqual(snapshot.numberOfItems, MockData.similarMovies.count)
        XCTAssertEqual(snapshot.numberOfSections, 1)
    }
}

struct MockData {
    static let movie = Movie(
        id: 1,
        title: "Test Movie",
        overview: "This is a test movie overview.",
        posterPath: "/test_backdrop.jpg",
        voteAverage: 8.5
    )

    static let movieDetails = MovieDetails(
        title: "Test Movie",
        overview: "This is a test movie overview.",
        backdropPath: "/test_backdrop.jpg",
        tagline: "Test Tagline"
    )

    static let similarMovies = [
        Movie(
            id: 1,
            title: "Similar Movie 1",
            overview: "Overview 1",
            posterPath: "/poster1.jpg",
            voteAverage: 8.0
        ),
        Movie(
            id: 2,
            title: "Similar Movie 2",
            overview: "Overview 2",
            posterPath: "/poster2.jpg",
            voteAverage: 7.5
        )
    ]
}
