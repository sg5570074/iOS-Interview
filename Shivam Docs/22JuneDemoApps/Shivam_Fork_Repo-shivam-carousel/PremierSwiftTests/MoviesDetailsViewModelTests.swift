//
//  MoviesDetailsViewModelTests.swift
//  PremierSwiftTests
//
//  Created by Shivam Gupta on 11/01/25.
//  Copyright © 2025 Deliveroo. All rights reserved.
//

import XCTest
@testable import PremierSwift

final class MoviesDetailsViewModelTests: XCTestCase {
    var viewModel: MoviesDetailsViewModel!
    var mockAPIManager: MockAPIManager!

    let movieDetails = MockData.movieDetails
    let similarMovies = MockData.similarMovies
    let movie = MockData.movie

    override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManager()
        mockAPIManager.movieDetails = movieDetails
        mockAPIManager.similarMovies = similarMovies

        viewModel = MoviesDetailsViewModel(movie: movie, apiManager: mockAPIManager)
    }

    func testInitialState() {
        XCTAssertEqual(viewModel.state.title, MockData.movie.title)
        XCTAssertEqual(viewModel.state, .loading(movie))
    }

    func testFetchDataSuccess() {
        mockAPIManager = MockAPIManager()
        mockAPIManager.movieDetails = movieDetails
        mockAPIManager.similarMovies = similarMovies

        viewModel = MoviesDetailsViewModel(movie: movie, apiManager: mockAPIManager)
        mockAPIManager.shouldReturnError = false
        let expectation = self.expectation(description: "State updated to loaded")

        viewModel.updatedState = {
            if case .loaded(let details, let similarMovies) = self.viewModel.state {
                XCTAssertEqual(details.title, "Test Movie")
                XCTAssertEqual(similarMovies.count, 2)
                XCTAssertEqual(similarMovies.first?.title, "Similar Movie 1")
                expectation.fulfill()
            }
        }

        viewModel.fetchData()
        waitForExpectations(timeout: 5.0)
    }

    func test_fetchData_failure() {
        mockAPIManager.shouldReturnError = true

        let expectation = self.expectation(description: "State should update to error")
        viewModel.updatedState = {
            if case .error = self.viewModel.state {
                expectation.fulfill()
            }
        }

        viewModel.fetchData()
        waitForExpectations(timeout: 1.0)
    }
}

final class MockAPIManager: APIManaging {
    var executeCallCount = 0
    var shouldReturnError = false
    var movieDetails: MovieDetails?
    var similarMovies: [Movie]?

    func execute<Value>(_ request: Request<Value>, completion: @escaping (Result<Value, APIError>) -> Void) where Value: Decodable {
        executeCallCount += 1

        if shouldReturnError {
            completion(.failure(.networkError))
        } else {
            if let movieDetails = movieDetails as? Value {
                completion(.success(movieDetails))
            } else if let similarMovies = similarMovies as? Page<Movie> {
                completion(.success(similarMovies as! Value))
            } else {
                completion(.failure(.parsingError))
            }
        }
    }
}
