//
//  MondiaMusicDecodingModelTests.swift
//  MondiaMusicListTests
//
//  Created by mac on 7/9/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest
@testable import MondiaMusicList

class MondiaMusicDecodingModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodingMusicRepsponse()
    {
        let musicBundle = Bundle(for: type(of: self))
        let path = musicBundle.path(forResource: "MusicList", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        do
        {
            let response = try JSONDecoder().decode([Music].self, from: data!)
            XCTAssert(response.count == 20)
        }
        catch {
            XCTFail()
        }
    }

}
