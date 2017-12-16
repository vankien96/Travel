//
//  FavoriteTourService.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/12/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import Foundation
class FavoriteTourService{
    static let share = FavoriteTourService()
    
    func getFavoriteTour(userID: String,completion: @escaping ((Bool,[FavoriteTour])->Void)){
        let api = "\(API.API_GETFAVOR)?userID=\(userID)"
        print(api)
        let url = URL(string: api)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data,error == nil else {completion(false,[]); return}
            do{
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                let success = jsonResult["return"] as! String
                print(success)
                if success == "true"{
                    let favoriteTours = jsonResult["message"] as! [Any]
                    var allFavorTours:[FavoriteTour] = []
                    for item in favoriteTours{
                        let favor = item as! [String:Any]
                        let favorID = favor["favoriteID"] as! String
                        let tourID = favor["TourID"] as! String
                        let favorTour = FavoriteTour(favoriteTour: favorID, userID: userID, tourID: tourID)
                        allFavorTours.append(favorTour)
                    }
                    completion(true, allFavorTours)
                }else{
                    completion(false,[])
                }
            }catch{
                completion(false,[])
            }
        }
        task.resume()
    }
    func setFavorite(userID:String,tourID:String,completion: @escaping ((Bool)->Void)){
        let url = URL(string: API.API_SETFAVORITE)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "userID=\(userID)&tourID=\(tourID)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription)
                completion(false)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("error HTTP")
                completion(false)
            }
            do{
                print("OK")
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                print(jsonResult)
                let success = jsonResult["return"] as! String
                if success == "true"{
                    completion(true)
                }else{
                    completion(false)
                }
            }catch{
                completion(false)
            }
        }
        task.resume()
    }
    func deleteFavorite(userID:String,tourID:String,completion: @escaping ((Bool)->Void)){
        let url = URL(string: API.API_DELETEFAVORITE)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "userID=\(userID)&tourID=\(tourID)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription)
                completion(false)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("error HTTP")
                completion(false)
            }
            do{
                print("OK")
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                print(jsonResult)
                let success = jsonResult["return"] as! String
                if success == "true"{
                    completion(true)
                }else{
                    completion(false)
                }
            }catch{
                completion(false)
            }
        }
        task.resume()
    }
}
