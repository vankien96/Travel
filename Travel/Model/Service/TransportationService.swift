//
//  TransportationService.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/11/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import Foundation
class TransportationService{
    static let share = TransportationService()
    func getAllTrans(completion: @escaping ((Bool,[Transportation]?)->Void)){
        let api = API.API_GETTRANS
        let url = URL(string: api)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data,error == nil else {completion(false,[]); return}
            do{
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                let success = jsonResult["return"] as! String
                print(success)
                if success == "true"{
                    let transportations = jsonResult["message"] as! [Any]
                    var allTrans:[Transportation] = []
                    for item in transportations{
                        let trans = item as! [String:Any]
                        let transID = trans["transfortationID"] as! String
                        let Name = trans["Name"] as! String
                        let Photo = trans["Photo"] as! String
                        let Thumbnail = trans["Thumbnail"] as! String
                        print(Thumbnail)
                        let imageThumb = "\(API.imageSource)/\(Thumbnail)"
                        let imageMain = "\(API.imageSource)/\(Photo)"
                        let transportation = Transportation(transportationID: transID, name: Name, image: imageMain, thumbnail: imageThumb)
                        allTrans.append(transportation)
                    }
                    completion(true, allTrans)
                }else{
                    completion(false,[])
                }
            }catch{
                completion(false,[])
            }
        }
        task.resume()
    }
    
    func getTransportation(transportationID: String,completion: @escaping ((Bool,Transportation?)->Void)){
        let api = "\(API.API_GETTRANS)?tranID=\(transportationID)"
        let url = URL(string: api)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data,error == nil else {completion(false,nil); return}
            do{
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                let success = jsonResult["return"] as! String
                print(success)
                if success == "true"{
                    let trans = jsonResult["message"] as! [String:Any]
                    let transID = trans["transfortationID"] as! String
                    let Name = trans["Name"] as! String
                    let Photo = trans["Photo"] as! String
                    let Thumbnail = trans["Thumbnail"] as! String
                    print(Thumbnail)
                    let imageThumb = "\(API.imageSource)/\(Thumbnail)"
                    let imageMain = "\(API.imageSource)/\(Photo)"
                    let transportation = Transportation(transportationID: transID, name: Name, image: imageMain, thumbnail: imageThumb)
                    completion(true, transportation)
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
