//
//  TopicCell.swift
//  reddit
//
//  Created by Quoc Huy Ngo on 7/16/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

protocol TopicCellDelegate {
    func topicDidChanged(topic: Topic)
}

class TopicCell: UITableViewCell {
    
    @IBOutlet weak var numberVotesLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var createdTime: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var upvoteButton: UIButton!
    @IBOutlet weak var downvoteButton: UIButton!
    
    var delegate: TopicCellDelegate?
    var topic: Topic? {
        didSet {
            guard let topic = topic else {
                return
            }
            contentLabel.text = topic.content
            nameLabel.text = topic.user.userName
            profileImage.image = UIImage(named: topic.user.profilePicture)
            
            if topic.upVote == 0 && topic.downVote == 0 {
                numberVotesLabel.text = "Vote"
            } else {
                numberVotesLabel.text = "\(topic.upVote - topic.downVote)"
            }
            setVote(state: topic.voteState)
        }
    }
    
    func setVote(state: VoteState) {
        switch state {
        case .none:
            upvoteButton.isSelected = false
            downvoteButton.isSelected = false
            break
        case .upvote:
            downvoteButton.isSelected = false
            upvoteButton.isSelected = true
            break
        case .downvote:
            upvoteButton.isSelected = false
            downvoteButton.isSelected = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let topic = topic {
            setVote(state: topic.voteState)
        }
        let radius = profileImage.layer.bounds.height/2
        profileImage.makeRounded(radius: radius)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func downvoteAction(_ sender: UIButton) {
        if sender.isSelected {
            topic?.voteState = .none
        } else {
            topic?.voteState = .downvote
            topic?.downVote += 1
        }
        delegate?.topicDidChanged(topic: self.topic!)
    }
    
    @IBAction func upvoteAction(_ sender: UIButton) {
        if sender.isSelected {
            topic?.voteState = .none
        } else {
            topic?.voteState = .upvote
            topic?.upVote += 1
        }
        delegate?.topicDidChanged(topic: self.topic!)
    }
}

extension UIView {
    func makeRounded(radius: CGFloat = 4) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
