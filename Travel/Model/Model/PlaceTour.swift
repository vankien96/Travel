//
//  PlaceTour.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/8/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import Foundation
class PlaceTour{
    public var placeID:String
    public var name:String
    public var address:String
    public var longDes:String
    public var shortDes:String
    public var photo:String
    public var thumbnail:String
    
    init(placeID:String,name:String,address:String,longDes:String,shortDes:String,photo:String,thumbnail:String) {
        self.placeID = placeID
        self.name = name
        self.address = address
        self.longDes = longDes
        self.shortDes = shortDes
        self.photo = photo
        self.thumbnail = thumbnail
    }
}
