//
//  TourService.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/9/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import Foundation
import Alamofire

class TourService{
    static let share = TourService()
    
    func getAllTour(completion: @escaping ((Bool,[Tour])->Void)){
        let api = API.API_GETALLTOUR
        let url = URL(string: api)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data,error == nil else {completion(false,[]); return}
            do{
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                let success = jsonResult["return"] as! String
                print(success)
                if success == "true"{
                    let tours = jsonResult["message"] as! [Any]
                    var allTours:[Tour] = [Tour]()
                    for item in tours{
                        let tourInfo = item as! [String:Any]
                        let tourID = tourInfo["TourID"] as! String
                        let title = tourInfo["Title"] as! String
                        let StartDate = tourInfo["StartDate"] as! String
                        let FinishDate = tourInfo["FinishDate"] as! String
                        let Price = tourInfo["Price"] as! String
                        let priceInt = Int(Price)
                        let TransportationID = tourInfo["TransportationID"] as! String
                        let HotelID = tourInfo["HotelID"] as! String
                        let PlaceID = tourInfo["PlaceID"] as! String
                        let Thumbnail = tourInfo["Thumbnail"] as! String
                        let thumb = "\(API.imageSource)/\(Thumbnail)"
                        let VoteStatus = tourInfo["VoteStatus"] as! String
                        let voteInt = Int(VoteStatus)
                        let AvailableSeat = tourInfo["AvailableSeat"] as! String
                        let availableSeat = Int(AvailableSeat)
                        
                        let oneTour = Tour(tourID: tourID, title: title, startDate: StartDate, finishDate: FinishDate, price: priceInt!, transportationID: TransportationID, hotelID: HotelID, placeID: PlaceID, thumbnail: thumb, vote: voteInt!, availableSeat: availableSeat!)
                        allTours.append(oneTour)
                    }
                    completion(true, allTours)
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
