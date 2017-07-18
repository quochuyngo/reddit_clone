//
//  ViewController.swift
//  reddit
//
//  Created by Quoc Huy Ngo on 7/16/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var topics: [Topic] =  Topic.fakeTopics()
    override func viewDidLoad() {
        super.viewDidLoad()
        initCells()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
    }

    func initCells() {
        tableView.register(UINib(nibName: String(describing: TopicCell.self), bundle: nil), forCellReuseIdentifier: "topicCell")
    }
    
    func footerView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 8))
        view.backgroundColor = Colors.gray
        return view
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
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell") as! TopicCell
        cell.topic = topics[indexPath.section]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case topics.count - 1:
            return 0
        default:
            return 8
        }
    }
}

extension HomeViewController: NewTopicViewControllerDelegate {
    func newPost(topic: Topic) {
        topics.insert(topic, at: 0)
        tableView.reloadData()
    }
}

extension HomeViewController: TopicCellDelegate {
    func topicDidChanged(topic: Topic) {
        if let index = topics.index(where: { $0.id == topic.id }) {
            topics[index] = topic
            tableView.reloadData()
        }
    }
}
