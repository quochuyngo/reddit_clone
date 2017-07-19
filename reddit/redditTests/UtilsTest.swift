//
//  UtilsTest.swift
//  reddit
//
//  Created by Quoc Huy Ngo on 7/19/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import XCTest
@testable import reddit

class UtilsTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDisplayVotes() {
        XCTAssertEqual(Utils.display(votes: 100), "100")
        XCTAssertEqual(Utils.display(votes: 2000), "2k")
        XCTAssertEqual(Utils.display(votes: 2200), "2.2k")
        XCTAssertEqual(Utils.display(votes: 2020), "2.0k")
        XCTAssertEqual(Utils.display(votes: 2345), "2.3k")
    }
    
//    func testFormatDate() {
//        let date = Date()
//        XCTAssertEqual(Utils.format(date: date), "4min")
//    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
