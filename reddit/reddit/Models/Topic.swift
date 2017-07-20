//
//  Topic.swift
//  reddit
//
//  Created by Quoc Huy Ngo on 7/17/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//
import UIKit

enum VoteState: String {
    case upvote
    case downvote
    case none
}
struct Topic {
    let id: String
    let user: User
    let createdDate: Date
    var content: String
    var upVote: Int
    var downVote: Int
    var voteState: VoteState
    
    static func createFakeTopics() -> [Topic] {
        var topics = [Topic]()
        let contents = ["Snapchat now allows exact location sharing"
                        , "How can we stop algorithms telling lies? Algorithms can dictate whether you get a mortgage or how much you pay for insurance. But sometimes they’re wrong – and sometimes they are designed to deceive"
                        , "10 startups in Asia that caught our eye. Here’s our newest round-up of the featured startups on our site this week."
                        , "SPRING Singapore commits $73m to co-invest in “deep tech” startups"
                        , "Working in the best tech company to work for. Yesterday, the Singapore Computer Society announced the winners of their Best Tech Company to Work For award, and Carousell was the overall winner for the Start-up category! Needless to say, we were jumping with joy when we heard the news!"]
        let pictures = ["reddit_logo_green", "reddit_logo_blue", "reddit_logo_pink"]
        let names = ["alan", "joe_parker", "catlin"]
        for _ in 0..<4 {
            for content in contents {
                let upvotes =  Int(arc4random_uniform(16))
                let downvotes = Int(arc4random_uniform(10))
                let index = Int(arc4random_uniform(3))
                let profilePicture = pictures[index]
                let name = names[index]
                let topic = Topic(id: Utils.getUUID()
                                    , user: User(userId: Utils.getUUID(), userName: name, profilePicture: profilePicture)
                                    , createdDate: Date()
                                    , content: content
                                    , upVote: upvotes
                                    , downVote: downvotes
                                    , voteState: .none)
                topics.append(topic)
            }
        }
        
        return topics
    }
}
