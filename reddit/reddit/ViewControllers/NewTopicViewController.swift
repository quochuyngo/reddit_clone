//
//  NewTopicViewController.swift
//  reddit
//
//  Created by Quoc Huy Ngo on 7/16/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class NewTopicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }

    override func viewDidDisappear(_ animated: Bool) {
                tabBarController?.tabBar.isHidden = false
    }
    @IBAction func postAction(_ sender: Any) {
    }
    @IBAction func cancelAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
}
