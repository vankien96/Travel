//
//  BookedTourService.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/12/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import Foundation
class BookedTourService{
    static let share = BookedTourService()
    
    func getBookedTour(userID:String,completion: @escaping ((Bool,[BookedTour])->Void)) {
        let api = "\(API.API_GETBOOKEDTOUR)?userID=\(userID)"
        print(api)
        let url = URL(string: api)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data,error == nil else {completion(false,[]); return}
            do{
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                let success = jsonResult["return"] as! String
                print(success)
                if success == "true"{
                    let bookedTour = jsonResult["message"] as! [Any]
                    var allBookedTours:[BookedTour] = []
                    for item in bookedTour{
                        let booked = item as! [String:Any]
                        let bookedID = booked["bookedID"] as! String
                        let tourID = booked["TourID"] as! String
                        let userID = booked["UserID"] as! String
                        
                        let bookedTourInfo = BookedTour(bookedID: bookedID, userID: userID, tourID: tourID)
                        allBookedTours.append(bookedTourInfo)
                    }
                    completion(true, allBookedTours)
                }else{
                    completion(false,[])
                }
            }catch{
                completion(false,[])
            }
        }
        task.resume()
    }
}
