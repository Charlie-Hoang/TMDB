//
//  MainVMTests.swift
//  TMDBTests
//
//  Created by Charlie on 1/9/23.
//

import XCTest
@testable import TMDB

extension MainCellVM: Equatable{
    public static func == (lhs: MainCellVM, rhs: MainCellVM) -> Bool{
        return lhs.movie_id == rhs.movie_id &&
            lhs.poster == rhs.poster &&
            lhs.title == rhs.title &&
            lhs.year == rhs.year &&
            lhs.rate == rhs.rate
    }
}

final class MainVMTests: XCTestCase {

    var mainVM: MainVM!
    var mockMovie: Movie!
    override func setUpWithError() throws {
        mainVM = MainVM(apiService: ApiService(baseURLString: URL_base))
        let mockJsonData = ApiService.loadSampleResponse(fileName: "MovieDetails0")
        mockMovie = try! JSONDecoder().decode(Movie.self, from: mockJsonData)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchTrendingMovie() throws {
        let expectation = XCTestExpectation(description: "Fetch trending movies successfully")
        
        mainVM.callback_reloadCollectionView = {
            expectation.fulfill()
        }
        mainVM.fetchTrendingMovie()
        wait(for: [expectation], timeout: 1.0)
    }
    func testFetchSearchingMovie() throws {
        let expectation = XCTestExpectation(description: "Fetch trending movies successfully")
        
        mainVM.callback_reloadCollectionView = {
            expectation.fulfill()
        }
        mainVM.fetchSearchingMovie(query: "John")
        wait(for: [expectation], timeout: 1.0)
    }
    func testFetchNextPage() throws {
        let expectation = XCTestExpectation(description: "Fetch trending movies successfully")
        
        mainVM.callback_reloadCollectionView = {
            expectation.fulfill()
        }
        mainVM.fetchNextPage()
        wait(for: [expectation], timeout: 1.0)
    }
    func testCreateCellVM() throws {
        let expectation = MainCellVM(movie_id: 335977, poster: URL(string: "https://image.tmdb.org/t/p/w200/Af4bXE63pVsb2FtbW8uYIyPBadD.jpg"), title: "Indiana Jones and the Dial of Destiny", year: "2023", rate: "6.7")
        let result = mainVM.createCellVM(movie: mockMovie!)
        XCTAssertEqual(expectation, result, "backdrop url should be equal to mock data!")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
