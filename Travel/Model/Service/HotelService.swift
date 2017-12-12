//
//  HotelService.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/11/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import Foundation
class HotelService{
    static let share = HotelService()
    
    func getAllHotel(completion: @escaping ((Bool,[Hotel])->Void)){
        let api = API.API_GETHOTEL
        let url = URL(string: api)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data,error == nil else {completion(false,[]); return}
            do{
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                let success = jsonResult["return"] as! String
                print(success)
                if success == "true"{
                    let hotels = jsonResult["message"] as! [Any]
                    var allHotel:[Hotel] = []
                    for item in hotels{
                        let hotelInfo = item as! [String:Any]
                        let HotelID = hotelInfo["HotelID"] as! String
                        let Name = hotelInfo["Name"] as! String
                        let Address = hotelInfo["Address"] as! String
                        let Phone = hotelInfo["Phone"] as! String
                        let Image = hotelInfo["Image"] as! String
                        let Detail = hotelInfo["Detail"] as! String
                        let imageSource = "\(API.imageSource)/\(Image)"
                        let hotel = Hotel(hotelID: HotelID, name: Name, address: Address, phone: Phone, image: imageSource, detail: Detail)
                        allHotel.append(hotel)
                    }
                    completion(true, allHotel)
                }else{
                    completion(false,[])
                }
            }catch{
                completion(false,[])
            }
        }
        task.resume()
    }
    func getHotel(hotelID: String,completion: @escaping ((Bool,Hotel?)->Void)){
        let api = "\(API.API_GETHOTEL)?hotelID=\(hotelID)"
        let url = URL(string: api)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data,error == nil else {completion(false,nil); return}
            do{
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                let success = jsonResult["return"] as! String
                print(success)
                if success == "true"{
                    let hotelInfo = jsonResult["message"] as! [String:Any]
                    let HotelID = hotelInfo["HotelID"] as! String
                    let Name = hotelInfo["Name"] as! String
                    let Address = hotelInfo["Address"] as! String
                    let Phone = hotelInfo["Phone"] as! String
                    let Image = hotelInfo["Image"] as! String
                    let Detail = hotelInfo["Detail"] as! String
                    let imageSource = "\(API.imageSource)/\(Image)"
                    let hotel = Hotel(hotelID: HotelID, name: Name, address: Address, phone: Phone, image: imageSource, detail: Detail)
                    completion(true, hotel)
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
