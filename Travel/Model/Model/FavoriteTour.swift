//
//  FavoriteTour.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/8/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import Foundation
class FavoriteTour{
    public var favoriteTour:String!
    public var userID:String!
    public var tourID:String!
    
    init(favoriteTour:String,userID:String,tourID:String) {
        self.favoriteTour = favoriteTour
        self.userID = userID
        self.tourID = tourID
    }
}
