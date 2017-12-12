//
//  PlaceDataService.swift
//  Travel
//
//  Created by Hien Nguyen on 11/30/17.
//  Copyright © 2017 Minori. All rights reserved.
//

import Foundation
class PlaceDataService {
    static let instance = PlaceDataService()
    func getPlaces(completion: @escaping ((Bool,[PlaceTour]?)->Void)){
        let api = API.API_GETPLACE
        let url = URL(string: api)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data,error == nil else {completion(false,[]); return}
            do{
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                let success = jsonResult["return"] as! String
                print(success)
                if success == "true"{
                    let places = jsonResult["message"] as! [Any]
                    var allPlace:[PlaceTour] = []
                    for item in places{
                        let placeInfo = item as! [String:Any]
                        
                        let placeID = placeInfo["PlaceID"] as! String
                        let Name = placeInfo["Name"] as! String
                        let Address = placeInfo["Address"] as! String
                        let LongDesc = placeInfo["LongDesc"] as! String
                        let ShortDesc = placeInfo["ShortDesc"] as! String
                        let PhotoName = placeInfo["Photo"] as! String
                        let ThumbnailName = placeInfo["Thumbnail"] as! String
                        let photoURL = "\(API.imageSource)/\(PhotoName)"
                        let thumbnailURL = "\(API.imageSource)/\(ThumbnailName)"
                        
                        let place = PlaceTour(placeID: placeID, name: Name, address: Address, longDes: LongDesc, shortDes: ShortDesc, photo: photoURL, thumbnail: thumbnailURL)
                        allPlace.append(place)
                    }
                    completion(true, allPlace)
                }else{
                    completion(false,[])
                }
            }catch{
                completion(false,[])
            }
        }
        task.resume()
    }
    func getPlace(placeID:String,completion: @escaping ((Bool,PlaceTour?)->Void)){
        let api = "\(API.API_GETPLACE)?placeID=\(placeID)"
        let url = URL(string: api)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data,error == nil else {completion(false,nil); return}
            do{
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                let success = jsonResult["return"] as! String
                print(success)
                if success == "true"{
                    let places = jsonResult["message"] as! [String:Any]
                    let placeID = places["PlaceID"] as! String
                    let Name = places["Name"] as! String
                    let Address = places["Address"] as! String
                    let LongDesc = places["LongDesc"] as! String
                    let ShortDesc = places["ShortDesc"] as! String
                    let PhotoName = places["Photo"] as! String
                    let ThumbnailName = places["Thumbnail"] as! String
                    let photoURL = "\(API.imageSource)/\(PhotoName)"
                    let thumbnailURL = "\(API.imageSource)/\(ThumbnailName)"
                    
                    let place = PlaceTour(placeID: placeID, name: Name, address: Address, longDes: LongDesc, shortDes: ShortDesc, photo: photoURL, thumbnail: thumbnailURL)
                    completion(true, place)
                }else{
                    completion(false,nil)
                }
            }catch{
                completion(false,nil)
            }
        }
        task.resume()
    }
}

