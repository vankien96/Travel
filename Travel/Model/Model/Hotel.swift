//
//  Hotel.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/8/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import Foundation
class Hotel{
    public var hotelID:String
    public var name:String
    public var address:String
    public var phone:String
    public var image:String
    public var detail:String
    
    init(hotelID:String,name:String,address:String,phone:String,image:String,detail:String) {
        self.hotelID = hotelID
        self.name = name
        self.address = address
        self.phone = phone
        self.image = image
        self.detail = detail
    }
}
