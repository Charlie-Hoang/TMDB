//
//  Dictionary+ExtTests.swift
//  TMDBTests
//
//  Created by Charlie on 1/9/23.
//

import XCTest
@testable import TMDB

final class Dictionary_ExtTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBuildQueryString() throws {
        let input = ["language": "en-US"]
        let expectation = "?language=en-US"
        let result = input.buildQueryString()
        XCTAssertEqual(result, expectation, "Should be equal!")
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
