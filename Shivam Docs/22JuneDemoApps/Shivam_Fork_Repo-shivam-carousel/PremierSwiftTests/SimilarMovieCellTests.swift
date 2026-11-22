//
//  SimilarMovieCellTests.swift
//  PremierSwiftTests
//
//  Created by Shivam Gupta on 11/01/25.
//  Copyright © 2025 Deliveroo. All rights reserved.
//

import XCTest
@testable import PremierSwift

final class SimilarMovieCellTests: XCTestCase {
    func testConfigureCell() {
        let cell = SimilarMovieCell()
        let movie = MockData.movie

        cell.configure(movie)

        XCTAssertEqual(cell.titleLabel.text, movie.title)
        XCTAssertEqual(cell.descriptionLabel.text, movie.overview)
        XCTAssertNil(cell.coverImage.image)
    }
}
