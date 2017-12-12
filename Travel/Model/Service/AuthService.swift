//
//  AuthService.swift
//  Travel
//
//  Created by Hien Nguyen on 11/30/17.
//  Copyright © 2017 Minori. All rights reserved.
//

import Foundation
class AuthService{
    static let instance = AuthService()
    func checkLogin(username:String,password:String,completion: @escaping ((Bool,User?)->Void)){
        let api = "\(API.API_CHECKLOGIN)?username=\(username)&password=\(password)"
        let urlLogin = URL(string: api)
        let task = URLSession.shared.dataTask(with: urlLogin!) { (data, response, error) in
            guard let data = data,error == nil else {completion(false,nil);return}
            do{
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                let success = jsonResult["return"] as! String
                print(success)
                if success == "true"{
                    let dataUser = jsonResult["message"] as! [String:Any]
                    let userID = dataUser["UserID"] as! String
                    let name = dataUser["Name"] as! String
                    let avatar = "\(API.imageSource)/\(dataUser["avatar"] as! String)"
                    let gender = dataUser["Gender"] as! String
                    let phone = dataUser["Phone"] as! String
                    let address = dataUser["Address"] as! String
                    let user = User(userID: userID, userName: name, userAvatar: avatar, address: address, gender: gender, phone: phone)
                    completion(true, user)
                }else{
                    completion(false,nil)
                }
            }catch{
                completion(false,nil)
            }
        }
        task.resume()
    }
    func getUserInfo(userID:String,completion: @escaping ((Bool,User?)->Void)){
        let api = "\(API.API_GETUSERINFO)?userID=\(userID)"
        let urlGetUser = URL(string: api)
        let task = URLSession.shared.dataTask(with: urlGetUser!) { (data, response, error) in
            guard let data = data,error == nil else {completion(false,nil); return}
            do{
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                let success = jsonResult["return"] as! String
                print(success)
                if success == "true"{
                    let dataUser = jsonResult["message"] as! [String:Any]
                    let userID = dataUser["UserID"] as! String
                    let name = dataUser["Name"] as! String
                    let avatar = "\(API.imageSource)/\(dataUser["avatar"] as! String)"
                    let gender = dataUser["Gender"] as! String
                    let phone = dataUser["Phone"] as! String
                    let address = dataUser["Address"] as! String
                    let user = User(userID: userID, userName: name, userAvatar: avatar, address: address, gender: gender, phone: phone)
                    completion(true, user)
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
