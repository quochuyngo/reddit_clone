//
//  User.swift
//  reddit
//
//  Created by Quoc Huy Ngo on 7/17/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import Foundation

struct User {
    let userId: String
    let userName: String
    let profilePicture: String
    
    static let currentUser = User(userId: Utils.getUUID(), userName: "huy_ngo", profilePicture: "reddit_logo")
}
