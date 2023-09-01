//
//  MovieTests.swift
//  TMDBTests
//
//  Created by Charlie on 1/9/23.
//

import XCTest
@testable import TMDB
extension Movies: Equatable{
    public static func == (lhs: Movies, rhs: Movies) -> Bool{
        var equal = true
        if let lresults = lhs.results, let rresults = rhs.results{
            if lresults.count != rresults.count {return false}
            for i in 0..<lresults.count{
                if lresults[i] != rresults[i] {return false}
            }
        }
        return lhs.page == rhs.page &&
            lhs.total_pages == rhs.total_pages &&
            lhs.total_results == rhs.total_results
    }
}
extension Movie: Equatable{
    public static func == (lhs: Movie, rhs: Movie) -> Bool{
        return lhs.adult == rhs.adult &&
            lhs.backdrop_path == rhs.backdrop_path &&
            lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.overview == rhs.overview &&
            lhs.poster_path == rhs.poster_path &&
            lhs.release_date == rhs.release_date
    }
}

final class MovieTests: XCTestCase {
    let mockJsonData = ApiService.loadSampleResponse(fileName: "MovieDetails0")
    var mockMovie: Movie?
    
    override func setUpWithError() throws {
        mockMovie = try! JSONDecoder().decode(Movie.self, from: mockJsonData)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPosterPathURL() throws {
        let expectation = URL(string: "https://image.tmdb.org/t/p/w200/Af4bXE63pVsb2FtbW8uYIyPBadD.jpg")
        let result = mockMovie?.posterPathURL(width: 200)
        XCTAssertEqual(expectation, result, "poster url should be equal to mock data!")
    }
    func tesBackdropPathURL() throws {
        let expectation = URL(string: "https://image.tmdb.org/t/p/w300/35z8hWuzfFUZQaYog8E9LsXW3iI.jpg")
        let result = mockMovie?.backdropPathURL(width: 300)
        XCTAssertEqual(expectation, result, "backdrop url should be equal to mock data!")
    }
    func testRateString() throws {
        let expectation = "6.7"
        let result = mockMovie?.rateString()
        XCTAssertEqual(expectation, result, "rating should be equal to \(expectation)!")
    }
    func testReleaseYear() throws {
        let expectation = "2023"
        let result = mockMovie?.releaseYear()
        XCTAssertEqual(expectation, result, "release year should be equal to \(expectation)!")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
