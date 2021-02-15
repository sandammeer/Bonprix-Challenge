//
//  BonprixChallengeUITests.swift
//  BonprixChallengeUITests
//
//  Created by Sandro Wehrhahn on 08.02.21.
//


import XCTest


class BonprixChallengeUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testTabbar() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.tabBars["tabbar_bonprix"].exists)
        XCTAssertTrue(app.tabForIndex(0, identifier: "tabbar_bonprix").exists)
        XCTAssertTrue(app.tabForIndex(0, identifier: "tabbar_bonprix").exists)
    }
    
    func testShopView() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.navigationBars.staticTexts["Shop"].exists)
        XCTAssertTrue(app.webViews["webview_container"].exists)
    }
    
    func testAssortmentsView() throws {
        let app = XCUIApplication()
        app.launch()

        app.tabForIndex(1, identifier: "tabbar_bonprix").tap()
        XCTAssertTrue(app.navigationBars.staticTexts["Sortiment"].exists)
        XCTAssertTrue(app.tables["tableview_assortments"].exists)
    }
    
    func testAssortmentsNavigateToSubcategoryView() throws {
        let app = XCUIApplication()
        app.launch()

        app.tabForIndex(1, identifier: "tabbar_bonprix").tap()
        XCTAssertTrue(app.navigationBars.staticTexts["Sortiment"].exists)

        app.tables["tableview_assortments"].staticTexts["Damen"].tap()
        XCTAssertTrue(app.navigationBars.staticTexts["Damen"].exists)
    }

}

extension XCUIApplication {
    
    func tabForIndex(_ index: Int, identifier: String) -> XCUIElement {
        tabBars[identifier].buttons.element(boundBy: index)
    }
    
}
