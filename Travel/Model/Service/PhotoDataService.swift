//
//  PhotoDataService.swift
//  Travel
//
//  Created by Hien Nguyen on 12/4/17.
//  Copyright © 2017 Minori. All rights reserved.
//

import Foundation
class PhotoDataService {
    static let instance = PhotoDataService()
    private let photos = [
    Photo(userID: "1", newfeedPhoto: "Photo.png", status: "Jennie Dean One of the best ways to make a great vacation quickly horrible is to choose the wrong accommodations for your trip.", timePhoto: "10 min ago", likeCount: 36),
    Photo(userID: "2", newfeedPhoto: "Photo2.png", status: "ennie Dean One of the best ways to make a great vacation quickly horrible is to choose the wrong accommodations for your trip.", timePhoto: "15 min ago", likeCount: 213),
    Photo(userID: "3", newfeedPhoto: "photo1.png", status: "ennie Dean One of the best ways to make a great vacation quickly horrible is to choose the wrong accommodations for your trip.", timePhoto: "24 min ago", likeCount: 1324),
    ]
    
    
    
    func getPhotos() -> [Photo] {
        return photos
    }
}
