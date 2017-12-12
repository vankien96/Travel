//
//  Transportation.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/8/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import Foundation
class Transportation{
    public var transportationID:String
    public var name:String
    public var image:String
    public var thumbnail:String
    
    
    init(transportationID:String,name:String,image:String,thumbnail:String) {
        self.transportationID = transportationID
        self.name = name
        self.image = image
        self.thumbnail = thumbnail
    }
}
