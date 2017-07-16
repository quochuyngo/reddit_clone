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
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell") as! TopicCell
        if indexPath.section == 2 {
            cell.contentLabel.text = "Here you are. We should go there tonight!"
        } else if indexPath.section == 3 {
            cell.contentLabel.text = "Here you are. We should go there tonight! Here you are. We should go there tonight!"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 7:
            return 0
        default:
            return 8
        }
    }
}


