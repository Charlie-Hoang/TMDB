//
//  EndpointTests.swift
//  TMDBTests
//
//  Created by Charlie on 2/9/23.
//

import XCTest
@testable import TMDB
final class EndpointTests: XCTestCase {

    let config = ApiServiceConfiguration(apiKey: TMDB_ApiKey)
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBaseURL() throws {
        let expectation = config.baseURLString.orEmpty()
        let results = [Endpoint.getTrendingMovies(time_window: .day, page: 1).baseURL(config),
                      Endpoint.searchMovies(query: "O", include_adult: false, page: 1).baseURL(config),
                      Endpoint.getMovieDetails(movie_id: 335977).baseURL(config)]
        for result in results{
            XCTAssertEqual(expectation, result, "result should be equal to \(expectation)!")
        }
    }
    func testPath() throws {
        let expectations = [config.path_trending_movies.orEmpty() + "/day",
                           config.path_search_movies,
                            config.path_movie_details.orEmpty() + "/\(335977)"]
        let results = [Endpoint.getTrendingMovies(time_window: .day, page: 1).path(config),
                      Endpoint.searchMovies(query: "O", include_adult: false, page: 1).path(config),
                      Endpoint.getMovieDetails(movie_id: 335977).path(config)]
        for (index, expectation) in expectations.enumerated(){
            XCTAssertEqual(expectation, results[index], "result should be equal to \(expectation.orEmpty())!")
        }
    }
    func testParams() throws {
//        let expectations = [config.path_trending_movies,
//                           config.path_search_movies,
//                           config.path_movie_details]
//        let results = [Endpoint.getTrendingMovies(time_window: .day, page: 1).path(config),
//                      Endpoint.searchMovies(query: "O", include_adult: false, page: 1).path(config),
//                      Endpoint.getMovieDetails(movie_id: 335977).path(config)]
//        for (index, expectation) in expectations.enumerated(){
//            XCTAssertEqual(expectation, results[index], "result should be equal to \(expectation.orEmpty())!")
//        }
    }
    func testMethod() throws {
        let expectation = "GET"
        let results = [Endpoint.getTrendingMovies(time_window: .day, page: 1).method(),
                      Endpoint.searchMovies(query: "O", include_adult: false, page: 1).method(),
                      Endpoint.getMovieDetails(movie_id: 335977).method()]
        for result in results{
            XCTAssertEqual(expectation, result, "result should be equal to \(expectation)!")
        }
    }
    func testIsCacheEnable() throws {
        let expectation = true
        let results = [Endpoint.getTrendingMovies(time_window: .day, page: 1).isCacheEnable(),
                      Endpoint.searchMovies(query: "O", include_adult: false, page: 1).isCacheEnable(),
                      Endpoint.getMovieDetails(movie_id: 335977).isCacheEnable()]
        for result in results{
            XCTAssertEqual(expectation, result, "result should be equal to \(expectation)!")
        }
    }
    func testBuildRequestURL() throws {
        let expectations = ["https://api.themoviedb.org/3/trending/movie/day?api_key=47aa75b56464da7a186b813a50035cd4&language=en-US&page=1",
                            "https://api.themoviedb.org/3/search/movie?language=en-US&include_adult=false&query=O&page=1&api_key=47aa75b56464da7a186b813a50035cd4",
                            "https://api.themoviedb.org/3/movie/335977?language=en-US&api_key=47aa75b56464da7a186b813a50035cd4"]
        let results = [Endpoint.getTrendingMovies(time_window: .day, page: 1).buildRequestURL(config: config)?.absoluteString,
                      Endpoint.searchMovies(query: "O", include_adult: false, page: 1).buildRequestURL(config: config)?.absoluteString,
                      Endpoint.getMovieDetails(movie_id: 335977).buildRequestURL(config: config)?.absoluteString]
        for result in results{
            XCTAssertTrue(result!.contains("api_key=47aa75b56464da7a186b813a50035cd4"), "should contain")
            XCTAssertTrue(result!.contains("language=en-US"), "should contain")
//            XCTAssertEqual(expectation, results[index], "result should be equal to \(expectation?.absoluteString ?? "")!")
        }
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}

