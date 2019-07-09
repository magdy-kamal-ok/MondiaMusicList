//
//  MondiaMusicCustomImageTests.swift
//  MondiaMusicListTests
//
//  Created by mac on 7/9/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest
@testable import MondiaMusicList

class MondiaMusicCustomImageTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPhotoDownloaded_ImageOrientation()
    {
        let expectedImageOrientation = UIImage.init(named: "testImage")?.imageOrientation
        guard let url = URL(string: Constants.imageTestUrl) else {
            XCTFail()
            return
        }
        let sessionExpectation = expectation(description: "session")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error
            {
                XCTFail(error.localizedDescription)
            }
            if let data = data {
                guard let image = UIImage(data: data) else {
                    XCTFail()
                    return
                }
                sessionExpectation.fulfill()
                XCTAssertEqual(image.imageOrientation, expectedImageOrientation)
            }
        }.resume()

        waitForExpectations(timeout: 15, handler: nil)
    }

}
