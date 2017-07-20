//
//  ViewController.swift
//  reddit
//
//  Created by Quoc Huy Ngo on 7/16/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    var popularTopics:[Topic] = []
    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        initCells()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl.addTarget(self, action: #selector(HomeViewController.refreshData(refreshControl:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        topics = (tabBarController as! CustomTabBarController).topics
        popularTopics = getPopularTopics()
    }
    
    func initCells() {
        tableView.register(UINib(nibName: String(describing: TopicCell.self), bundle: nil), forCellReuseIdentifier: "topicCell")
    }
    
    func footerView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 8))
        view.backgroundColor = Colors.gray
        return view
    }
    
    //update newest data from list topics while user had upvotes/downvotes
    func refreshData(refreshControl: UIRefreshControl) {
        popularTopics = getPopularTopics()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewTopicVCSegue" {
            let vc = segue.destination as! NewTopicViewController
            vc.hidesBottomBarWhenPushed = true
            vc.delegate  = self
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return popularTopics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell") as! TopicCell
        cell.topic = popularTopics[indexPath.section]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case popularTopics.count - 1:
            return 0
        default:
            return 8
        }
    }
}

extension HomeViewController: NewTopicViewControllerDelegate {
    //add new topic created by user to list topic
    func newPost(topic: Topic) {
        topics.append(topic)
         (tabBarController as! CustomTabBarController).topics = topics
        popularTopics = getPopularTopics()
        tableView.reloadData()
    }
}

extension HomeViewController: TopicCellDelegate {
    //update topic upvoted/downvoted to list topics
    func topicDidChanged(topic: Topic) {
        if let index = topics.index(where: { $0.id == topic.id }) {
            topics[index] = topic
             (tabBarController as! CustomTabBarController).topics = topics
            popularTopics = getPopularTopics()
        }
    }
}
