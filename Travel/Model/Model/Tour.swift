//
//  Tour.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/8/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import UIKit
class Tour{
    public var tourID:String!
    public var title:String!
    public var startDate:String!
    public var finishDate:String!
    public var price:Int!
    public var transportationID:String!
    public var hotelID:String!
    public var placeID:String!
    public var thumbnail:String!
    public var vote:Int!
    public var availableSeat:Int!
    
    init(tourID:String,title:String,startDate:String,finishDate:String,price:Int,transportationID:String,hotelID:String,placeID:String,thumbnail:String,vote:Int,availableSeat:Int) {
        self.tourID = tourID
        self.title = title
        self.startDate = startDate
        self.finishDate = finishDate
        self.price  = price
        self.transportationID = transportationID
        self.hotelID = hotelID
        self.placeID = placeID
        self.thumbnail = thumbnail
        self.vote = vote
        self.availableSeat = availableSeat
    }
    
}
