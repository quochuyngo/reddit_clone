//
//  BaseViewController.swift
//  reddit
//
//  Created by Quoc Huy Ngo on 7/18/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var topics: [Topic] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        topics = (self.tabBarController as! CustomTabBarController).topics
    }
    
    //return list of topics created by current user
    func getMyTopics() -> [Topic] {
        return topics.filter{ $0.user.userId == User.currentUser.userId }
    }
    
    //return list of topics sorted by upvote (decsending)
    func sortByUpvotes() -> [Topic]{
        var result = [Topic]()
        result = topics.sorted(by: { $0.upVote > $1.upVote })
        return result
    }
    
    //return 20 topics from sorted list
    func getPopularTopics() -> [Topic] {
        return Array(sortByUpvotes().prefix(20))
    }
}
