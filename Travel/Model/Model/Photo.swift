//
//  Photo.swift
//  Travel
//
//  Created by Hien Nguyen on 12/4/17.
//  Copyright © 2017 Minori. All rights reserved.
//

import Foundation
class Photo {
    public var userID: String
    public var newfeedPhoto: String
    public var status : String
    public var timePhoto : String
    public var likeCount : Int

    init(userID : String, newfeedPhoto : String, status : String, timePhoto : String, likeCount : Int) {
        self.userID = userID
        self.newfeedPhoto = newfeedPhoto
        self.status = status
        self.timePhoto = timePhoto
        self.likeCount = likeCount
    }
}

