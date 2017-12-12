//
//  User.swift
//  Travel
//
//  Created by Hien Nguyen on 12/4/17.
//  Copyright © 2017 Minori. All rights reserved.
//

import Foundation
class User {
    private(set) public var userID : String
    private(set) public var userName : String
    private(set) public var userAvatar : String
    private(set) public var address: String?
    private(set) public var gender:String
    private(set) public var phone:String?

    init(userID : String, userName : String, userAvatar : String, address: String,gender:String,phone:String?) {
        self.userID = userID
        self.userName = userName
        self.userAvatar = userAvatar
        self.address = address
        self.gender = gender
        self.phone = phone
    }
}

