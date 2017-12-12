//
//  Setting.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/8/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import Foundation
class Setting{
    public var imageName:String
    public var name:String
    
    init(image:String,name:String) {
        self.imageName = image
        self.name = name
    }
    class func getSetting()-> [Setting]{
        var settings = [Setting]()
        
        var setting = Setting(image: "location", name: "Thêm địa điểm")
        settings.append(setting)
        setting = Setting(image: "notification", name: "Thông báo")
        settings.append(setting)
        setting = Setting(image: "voted", name: "Đánh giá ứng dụng")
        settings.append(setting)
        setting = Setting(image: "findFriend", name: "Tìm bạn bè")
        settings.append(setting)
        setting = Setting(image: "setting", name: "Cài đặt")
        settings.append(setting)
        
        return settings
    }
}
