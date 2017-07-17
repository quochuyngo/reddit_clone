//
//  Topic.swift
//  reddit
//
//  Created by Quoc Huy Ngo on 7/17/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//
import UIKit

struct Topic {
    let id: String
    let user: User
    let createdDate: Date
    var content: String
    var upVote: Int
    var downVote: Int
    
    static func fakeTopics() -> [Topic] {
        var topics = [Topic]()
        let contents = ["Snapchat now allows exact location sharing"
                        , "How can we stop algorithms telling lies? Algorithms can dictate whether you get a mortgage or how much you pay for insurance. But sometimes they’re wrong – and sometimes they are designed to deceive"
                        , "10 startups in Asia that caught our eye. Here’s our newest round-up of the featured startups on our site this week."
                        , "SPRING Singapore commits $73m to co-invest in “deep tech” startups"
                        , "Working in the best tech company to work for. Yesterday, the Singapore Computer Society announced the winners of their Best Tech Company to Work For award, and Carousell was the overall winner for the Start-up category! Needless to say, we were jumping with joy when we heard the news!"]
        
        for _ in 0..<4 {
            for content in contents {
                let topic = Topic(id: Utils.getUUID(), user: User(userId: Utils.getUUID(), userName: "huy_ngo", profilePicture: "reddit_logo"), createdDate: Date(), content: content, upVote: 0, downVote: 0)
                topics.append(topic)
            }
        }
        
        return topics
    }
}
