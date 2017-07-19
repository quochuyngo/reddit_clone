//
//  redditTests.swift
//  redditTests
//
//  Created by Quoc Huy Ngo on 7/16/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import XCTest
@testable import reddit

class redditTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let topic = Topic(id: Utils.getUUID(), user: User(userId: Utils.getUUID(), userName: "testname", profilePicture: ""), createdDate: Date(), content: "test", upVote: 0, downVote: 0, voteState: .none)
        let topic1 = Topic(id: Utils.getUUID(), user: User.currentUser, createdDate: Date(), content: "test", upVote: 0, downVote: 0, voteState: .none)
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
