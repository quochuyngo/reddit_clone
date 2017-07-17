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
    
    var topic: Topic? {
        didSet {
            contentLabel.text = topic?.content
            nameLabel.text = topic?.user.userName
            if let image = topic?.user.profilePicture {
                profileImage.image = UIImage(named: image)
            }
            
            if topic?.upVote == 0 && topic?.downVote == 0 {
                numberVotesLabel.text = "Vote"
            } else {
                numberVotesLabel.text = "\(topic?.upVote)"
            }
        }
    }
    
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
        
    }
    
    @IBAction func upvoteAction(_ sender: Any) {
        
    }
}

extension UIView {
    func makeRounded(radius: CGFloat = 4) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
