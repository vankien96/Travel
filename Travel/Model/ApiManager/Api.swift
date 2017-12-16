//
//  Api.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/9/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import Foundation
struct API{
    static let domain = "http://192.168.1.17/Travel"
    static let imageSource = "\(API.domain)/Image"
    //get all tour
    static let API_GETALLTOUR = "\(API.domain)/getAllTour.php"
    static let API_CHECKLOGIN = "\(API.domain)/checkSignIn.php"
    static let API_GETUSERINFO = "\(API.domain)/getUserData.php"
    static let API_GETHOTEL = "\(API.domain)/getHotel.php"
    static let API_GETPLACE = "\(API.domain)/getPlace.php"
    static let API_GETTRANS = "\(API.domain)/getTrans.php"
    static let API_GETFAVOR = "\(API.domain)/getFavorTour.php"
    static let API_GETBOOKEDTOUR = "\(API.domain)/getBookedTour.php"
    static let API_SETFAVORITE = "\(API.domain)/setFavorite.php"
    static let API_DELETEFAVORITE = "\(API.domain)/deleteFavorite.php"
    static let API_SETBOOKTOUR = "\(API.domain)/setBookTour.php"
    static let API_DELETEBOOKTOUR = "\(API.domain)/deleteBooked.php"
}
