//
//  CustomTabBarViewController.swift
//  reddit
//
//  Created by Quoc Huy Ngo on 7/18/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit
class CustomTabBarController: UITabBarController {
   
    var topics: [Topic] = []
    override func viewDidLoad() {
        topics = Topic.createFakeTopics()
    }
}
