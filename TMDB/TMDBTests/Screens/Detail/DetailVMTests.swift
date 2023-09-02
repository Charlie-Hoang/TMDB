//
//  DetailVMTests.swift
//  TMDBTests
//
//  Created by Charlie on 1/9/23.
//

import XCTest
@testable import TMDB

final class DetailVMTests: XCTestCase {
    var detailVM: DetailVM!
    var mockMovie: Movie!
    
    override func setUpWithError() throws {
        
        let mockJsonData = ApiService.loadSampleResponse(fileName: "MovieDetails0")
        mockMovie = try! JSONDecoder().decode(Movie.self, from: mockJsonData)
        detailVM = DetailVM(apiService: ApiService(config: ApiServiceConfiguration(apiKey: TMDB_ApiKey)), movie_id: mockMovie.id!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchDetail() throws {
        let expectation = XCTestExpectation(description: "Fetch trending movies successfully")
        
        detailVM.callback_reloadView = {
            expectation.fulfill()
        }
        detailVM?.fetchDetail()
        wait(for: [expectation], timeout: 1.0)
    }
    func testProcessMovieDetail() throws {
        
        detailVM.processMovieDetail(movie: mockMovie)
        
        XCTAssertEqual(detailVM.title, mockMovie.title, "Should be equal")
        XCTAssertEqual(detailVM.backdropURL, URL(string: "https://image.tmdb.org/t/p/w300/35z8hWuzfFUZQaYog8E9LsXW3iI.jpg"), "Should be equal")
        XCTAssertEqual(detailVM.year, mockMovie.releaseYear(), "Should be equal")
        XCTAssertEqual(detailVM.overview, mockMovie.overview, "Should be equal")
        XCTAssertEqual(detailVM.rate, mockMovie.rateString(), "Should be equal")
    }
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
