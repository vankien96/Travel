//
//  BookedTour.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/8/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import Foundation
class BookedTour{
    public var bookedID:String
    public var userID:String?
    public var tourID:String
    init(bookedID:String,userID:String?,tourID:String) {
        self.bookedID = bookedID
        self.userID = userID
        self.tourID = tourID
    }
}
