//
//  ApiServiceTests.swift
//  TMDBTests
//
//  Created by Charlie on 1/9/23.
//

import XCTest
@testable import TMDB

extension ApiService{
    static func loadSampleResponse(fileName: String) -> Data{
        @objc class TestClass: NSObject{}
        let bundle = Bundle(for: TestClass.self)
        let p = bundle.path(forResource: fileName, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: p!))) ?? Data()
    }
}
final class ApiServiceTests: XCTestCase {

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    //MARK: - Test Trending Movies -
    func testFetchTrendingMoviesSuccess() throws {
        let mockJsonData = ApiService.loadSampleResponse(fileName: "TrendingMovies0")
        let mockMovies = try! JSONDecoder().decode(Movies.self, from: mockJsonData)
        let expectation = XCTestExpectation(description: "Fetch trending movies successfully")
        
        let apiService = ApiService(config: ApiServiceConfiguration(apiKey: TMDB_ApiKey))
        
        apiService.fetchTrendingMovies(time_window: .day, page: 1, completion: {result in
            switch result{
            case .success(let res):
                //need to update mock data for testing because data from server is changing
                //XCTAssertEqual(res, mockMovies, "Response should be equal with mock trending movies")
                break
            case .failure(_):
                XCTFail("Should not fail")
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
    }
    func testFetchTrendingMoviesFailure() throws {
        
        let expectation = XCTestExpectation(description: "Fetch movies with failure")
        
        let apiService = ApiService(config: ApiServiceConfiguration(apiKey: TMDB_ApiKey + "somethingwrong"))
        
        apiService.fetchTrendingMovies(time_window: .day, page: 1, completion: {result in
            switch result{
            case .success(_):
                XCTFail("Should not success")
            case .failure(_):
                XCTAssert(true)
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
    }

    func testPerformanceFetchTrendingMovies() throws {
        // This is an example of a performance test case.
        self.measure {
            let apiService = ApiService(config: ApiServiceConfiguration(apiKey: TMDB_ApiKey))
            apiService.fetchTrendingMovies(time_window: .day, page: 1, completion: {result in
                switch result{
                case .success(_):
                    XCTAssert(true)
                case .failure(_):
                    XCTFail("Should not fail")
                }
            })
        }
    }
    //MARK: - Test Searching Movies -
    func testSearchMoviesSuccess() throws {
        let mockJsonData = ApiService.loadSampleResponse(fileName: "SearchingMovies0")
        let mockMovies = try! JSONDecoder().decode(Movies.self, from: mockJsonData)
        let expectation = XCTestExpectation(description: "Fetch trending movies successfully")
        
        let apiService = ApiService(config: ApiServiceConfiguration(apiKey: TMDB_ApiKey))
        
        apiService.searchMovies(query: "O", page: 1, completion: { result in
            switch result{
            case .success(let res):
                //need to update mock data for testing because data from server is changing
                //XCTAssertEqual(res, mockMovies, "Response should be equal to mock search movies")
                break
            case .failure(_):
                XCTFail("Should not fail")
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
    }
    func testSearchMoviesFailure() throws {
        
        let expectation = XCTestExpectation(description: "Fetch movies with failure")
        
        let apiService = ApiService(config: ApiServiceConfiguration(apiKey: TMDB_ApiKey + "somethingwrong"))
        
        apiService.searchMovies(query: "O", page: 1, completion: { result in
            switch result{
            case .success(_):
                XCTFail("Should not success")
            case .failure(_):
                XCTAssert(true)
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
    }

    func testPerformanceSearchMovies() throws {
        // This is an example of a performance test case.
        self.measure {
            let apiService = ApiService(config: ApiServiceConfiguration(apiKey: TMDB_ApiKey))
            
            apiService.searchMovies(query: "O", page: 1, completion: { result in
                switch result{
                case .success(_):
                    XCTAssert(true)
                case .failure(_):
                    XCTFail("Should not fail")
                }
            })
            
        }
    }
    //MARK: - Test Movie Details -
    func testFetchMovieDetailsSuccess() throws {
        let mockJsonData = ApiService.loadSampleResponse(fileName: "MovieDetails0")
        let mockMovie = try! JSONDecoder().decode(Movie.self, from: mockJsonData)
        let expectation = XCTestExpectation(description: "Fetch trending movies successfully")
        
        let apiService = ApiService(config: ApiServiceConfiguration(apiKey: TMDB_ApiKey))
        
        apiService.fetchMovieDetails(movie_id: 335977, completion: { result in
            switch result{
            case .success(let res):
                XCTAssertEqual(res, mockMovie, "Response should be equal with mock movie details")
            case .failure(_):
                XCTFail("Should not fail")
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
    }
    func testFetchMovieDetailsFailure() throws {
        
        let expectation = XCTestExpectation(description: "Fetch movies with failure")
        
        let apiService = ApiService(config: ApiServiceConfiguration(apiKey: TMDB_ApiKey + "somethingWrong"))
        apiService.fetchMovieDetails(movie_id: 335977, completion: { result in
            switch result{
            case .success(_):
                XCTFail("Should not success")
            case .failure(_):
                XCTAssert(true)
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
    }

    func testPerformanceFetchMovieDetails() throws {
        // This is an example of a performance test case.
        self.measure {
            let apiService = ApiService(config: ApiServiceConfiguration(apiKey: TMDB_ApiKey))
            
            apiService.fetchMovieDetails(movie_id: 335977, completion: { result in
                switch result{
                case .success(_):
                    XCTAssert(true)
                case .failure(_):
                    XCTFail("Should not fail")
                }
            })
            
        }
    }
}
