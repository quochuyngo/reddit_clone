//
//  TopicCell.swift
//  reddit
//
//  Created by Quoc Huy Ngo on 7/16/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class TopicCell: UITableViewCell {
    @IBOutlet weak var numberVotesLabel: UILabel!

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var createdTime: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        let radius = profileImage.layer.bounds.height/2
        profileImage.makeRounded(radius: radius)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func downvoteAction(_ sender: Any) {
        print("downVote")
    }
    @IBAction func upvoteAction(_ sender: Any) {
            print("upVote")
    }
}

extension UIView {
    func makeRounded(radius: CGFloat = 4) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
