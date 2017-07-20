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
    
    @IBOutlet weak var numberUpVotesLabel: UILabel!
    @IBOutlet weak var numberDownVotesLabel: UILabel!
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
            createdTime.text = Utils.format(date: topic.createdDate)
            numberDownVotesLabel.text = Utils.display(votes: topic.downVote)
            numberUpVotesLabel.text = Utils.display(votes: topic.upVote)
            setVote(state: topic.voteState)
        }
    }
    
    func setVote(state: VoteState) {
        switch state {
        case .none:
            upvoteButton.isSelected = false
            downvoteButton.isSelected = false
            numberUpVotesLabel.textColor = Colors.grayCountLabel
            numberDownVotesLabel.textColor =  Colors.grayCountLabel

            break
        case .upvote:
            downvoteButton.isSelected = false
            upvoteButton.isSelected = true
            numberUpVotesLabel.textColor = Colors.orangeUpvoted
            numberDownVotesLabel.textColor =  Colors.grayCountLabel
            break
        case .downvote:
            upvoteButton.isSelected = false
            downvoteButton.isSelected = true
            numberDownVotesLabel.textColor = Colors.purpleDownvoted
            numberUpVotesLabel.textColor =  Colors.grayCountLabel
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

    //update number of downvotes and set state
    @IBAction func downvoteAction(_ sender: UIButton) {
        if sender.isSelected {
            topic?.voteState = .none
        } else {
            topic?.downVote += 1
            topic?.voteState = .downvote
        }
        delegate?.topicDidChanged(topic: self.topic!)
    }
    
    //update number of upvotes and set state
    @IBAction func upvoteAction(_ sender: UIButton) {
        if sender.isSelected {
            topic?.voteState = .none
        } else {
            topic?.upVote += 1
            topic?.voteState = .upvote
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
