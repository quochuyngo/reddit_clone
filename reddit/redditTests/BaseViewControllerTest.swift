//
//  BaseViewControllerTest.swift
//  reddit
//
//  Created by Quoc Huy Ngo on 7/19/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import XCTest
@testable import reddit

class BaseViewControllerTest: XCTestCase {
    let baseVC = BaseViewController()

    override func setUp() {
        super.setUp()
        baseVC.topics.append(Topic(id: Utils.getUUID(), user: User (userId: Utils.getUUID(), userName: "first", profilePicture: ""), createdDate: Date(), content: "Test1", upVote: 12, downVote: 4, voteState: .none))
        baseVC.topics.append(Topic(id: Utils.getUUID(), user: User (userId: Utils.getUUID(), userName: "second", profilePicture: ""), createdDate: Date(), content: "Test2", upVote: 20, downVote: 7, voteState: .none))
        baseVC.topics.append(Topic(id: Utils.getUUID(), user: User (userId: Utils.getUUID(), userName: "third", profilePicture: ""), createdDate: Date(), content: "Test3", upVote: 4, downVote: 7, voteState: .none))
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMyPostExist() {
        let topic = Topic(id: Utils.getUUID(), user: User.currentUser, createdDate: Date(), content: "test", upVote: 0, downVote: 0, voteState: .none)
        baseVC.topics.append(topic)
        let result = 1
        XCTAssertEqual(baseVC.getMyTopics().count, result)
    }
    
    func testMyPostNotExist() {
        let result = 0
        XCTAssertEqual(baseVC.getMyTopics().count, result)
    }
    
    func testSortByVote() {
        XCTAssertEqual(baseVC.sortByUpvotes().first?.user.userName, "second")
    }
    
    func testGetPopularTopics() {
        baseVC.topics += Topic.fakeTopics()
        XCTAssertEqual(baseVC.getPopularTopics().count, 20)
        XCTAssertEqual(baseVC.sortByUpvotes().first?.user.userName, "second")
    }
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
