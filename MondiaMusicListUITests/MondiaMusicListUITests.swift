//
//  MondiaMusicListUITests.swift
//  MondiaMusicListUITests
//
//  Created by mac on 7/9/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest
@testable import MondiaMusicList
class MondiaMusicListUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testMusicListLoaded() {
        app.launch()
        let tableView = app.tables[Constants.tableViewIdentifier]
        let count = tableView.cells.count
        XCTAssert(count == 0)

    }

    func testMusicTableViewList() {
        app.launch()
        let searchBar = app.otherElements[Constants.searchBarIdentifier]
        searchBar.tap()
        searchBar.typeText("ASD\n")
        let tableView = app.tables[Constants.tableViewIdentifier]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: tableView) { () -> Bool in
            XCTAssert(tableView.cells.count == 20)
            return tableView.cells.count == 20
        }
        waitForExpectations(timeout: 10, handler: nil)


    }


    func testMusicImageExists() {
        app.launch()
        let searchBar = app.otherElements[Constants.searchBarIdentifier]
        searchBar.tap()
        searchBar.typeText("ASD\n")
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.element(boundBy: 0)
        let posterImage = firstCell.images[Constants.coverImageIdentifier]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: posterImage, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testMusicArtistNameExists() {
        app.launch()
        let searchBar = app.otherElements[Constants.searchBarIdentifier]
        searchBar.tap()
        searchBar.typeText("ASD\n")
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.element(boundBy: 0)
        let musicArtistName = firstCell.staticTexts[Constants.artistNameLabelIdentifier]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: musicArtistName, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
    }
    func testMusicTitleExists() {
        app.launch()
        let searchBar = app.otherElements[Constants.searchBarIdentifier]
        searchBar.tap()
        searchBar.typeText("ASD\n")
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.element(boundBy: 0)
        let musicTitle = firstCell.staticTexts[Constants.musicTitleLabelIdentifier]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: musicTitle, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
    }
    func testMusicTypeExists() {
        app.launch()
        let searchBar = app.otherElements[Constants.searchBarIdentifier]
        searchBar.tap()
        searchBar.typeText("ASD\n")
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.element(boundBy: 0)
        let musicType = firstCell.staticTexts[Constants.musicTypeLabelIdentifier]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: musicType, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testMusicZoomInImage() {
        app.launch()
        let searchBar = app.otherElements[Constants.searchBarIdentifier]
        searchBar.tap()
        searchBar.typeText("ASD\n")
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.element(boundBy: 0)
        let posterImage = firstCell.images[Constants.coverImageIdentifier]

        let zoomImage = app.images[Constants.zoomedCoverImageIdentifier]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: posterImage) { () -> Bool in
            posterImage.tap()
            XCTAssert(zoomImage.exists)
            return zoomImage.exists
        }
        waitForExpectations(timeout: 10, handler: nil)

    }
    func testMusicZoomInOutImage() {
        app.launch()
        let searchBar = app.otherElements[Constants.searchBarIdentifier]
        searchBar.tap()
        searchBar.typeText("ASD\n")
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.element(boundBy: 0)
        let posterImage = firstCell.images[Constants.coverImageIdentifier]

        let zoomImage = app.images[Constants.zoomedCoverImageIdentifier]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: posterImage) { () -> Bool in
            posterImage.tap()
            zoomImage.tap()
            XCTAssert(posterImage.exists)
            return posterImage.exists
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    func testMusicOpenDetails() {
        app.launch()
        let searchBar = app.otherElements[Constants.searchBarIdentifier]
        searchBar.tap()
        searchBar.typeText("ASD\n")
        let tableView = app.tables[Constants.tableViewIdentifier]
        let firstCell = tableView.cells.element(boundBy: 0)
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: firstCell) { () -> Bool in
            firstCell.tap()
            let navBarTitle = self.app.navigationBars.firstMatch
            XCTAssert(navBarTitle.identifier == "Music Details")
            return navBarTitle.identifier == "Music Details"
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    // please make sure you turn off mobile data and wifi
    func testNoInternetConnectionAlert()
    {
        app.launch()
        let searchBar = app.otherElements[Constants.searchBarIdentifier]
        searchBar.tap()
        searchBar.typeText("ASD\n")
        let alert = app.alerts.firstMatch
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: alert, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testAs()
    {

        let app = XCUIApplication()
        app.otherElements["searchBar"].children(matching: .searchField).element.tap()

        let clearTextSearchField = app/*@START_MENU_TOKEN@*/.searchFields.containing(.button, identifier: "Clear text").element/*[[".otherElements[\"searchBar\"].searchFields.containing(.button, identifier:\"Clear text\").element",".searchFields.containing(.button, identifier:\"Clear text\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        clearTextSearchField.tap()
        app.alerts["Warning"].buttons["Ok"].tap()
        clearTextSearchField.tap()

    }
}
extension XCUIElement {
    func scrollToElement(element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }

    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
}
