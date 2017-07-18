//
//  MyTopicViewController.swift
//  reddit
//
//  Created by Quoc Huy Ngo on 7/18/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class MyTopicViewController: HomeViewController {
    var myTopics: [Topic] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        topics = (tabBarController as! CustomTabBarController).topics
        myTopics = getMyTopics()
        tableView.reloadData()
    }
}

extension MyTopicViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return myTopics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell") as! TopicCell
        cell.topic = myTopics[indexPath.section]
        cell.delegate = self
        return cell
    }
}
