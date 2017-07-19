//
//  MyTopicViewController.swift
//  reddit
//
//  Created by Quoc Huy Ngo on 7/18/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class MyTopicViewController: HomeViewController {

    @IBOutlet weak var infoLabel: UILabel!
    var myTopics: [Topic] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        topics = (tabBarController as! CustomTabBarController).topics
        myTopics = getMyTopics()
        if myTopics.count == 0 {
            infoLabel.isHidden = false
        } else {
            infoLabel.isHidden = true
        }
        tableView.reloadData()
    }
    
    override func refreshData(refreshControl: UIRefreshControl) {
        myTopics = getMyTopics()
        tableView.reloadData()
        refreshControl.endRefreshing()
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
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case myTopics.count - 1:
            return 0
        default:
            return 8
        }
    }
}
