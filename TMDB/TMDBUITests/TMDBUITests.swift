//
//  TMDBUITests.swift
//  TMDBUITests
//
//  Created by Charlie on 30/8/23.
//

import XCTest

final class TMDBUITests: XCTestCase {
    
    override func setUpWithError() throws {
        
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        
    }
    func testMain() throws{
        let app = XCUIApplication()
        app.launch()
        let detailTitleLabel0 = app.staticTexts["Indiana Jones and the Dial of Destiny"]
        XCTAssertTrue(detailTitleLabel0.exists)
        
        let detailTitleLabel1 = app.staticTexts["The Last Voyage of the Demeter"]
        XCTAssertTrue(detailTitleLabel1.exists)
        
        let detailTitleLabel2 = app.staticTexts["Meg 2: The Trench"]
        XCTAssertTrue(detailTitleLabel2.exists)
    }
    func testSearch() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let searchBar = app.searchFields
        XCTAssertTrue(searchBar.element.exists)
        XCTAssertEqual(searchBar.element.placeholderValue, "Search", "Place holder should be 'Search'")
        searchBar.element.tap()
        searchBar.element.typeText("O")
        
        let onepiece = app.collectionViews.children(matching: .any).element(boundBy: 0)
        XCTAssert(onepiece.exists)
    }
    func testOpenDetail() throws {
        let app = XCUIApplication()
        app.launch()
        app.collectionViews.cells.element(boundBy:0).tap()
        
        let detailTitleLabel = app.staticTexts["Indiana Jones and the Dial of Destiny"]
        XCTAssertTrue(detailTitleLabel.exists)

        let yearLabel = app.staticTexts["2023"]
        XCTAssertTrue(yearLabel.exists)

        let rateLabel = app.staticTexts["6.7"]
        XCTAssertTrue(rateLabel.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
