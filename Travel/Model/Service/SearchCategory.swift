//
//  SearchCategory.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/11/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import Foundation
class SearchCategoryModel{
    public var image:String
    public var name:String
    
    init(image:String,name:String) {
        self.image = image
        self.name = name
    }
    
    class func getAllCategory() -> [SearchCategoryModel]{
        var categorys:[SearchCategoryModel] = []
        var category = SearchCategoryModel(image: "tour", name: "Tìm kiếm Tour")
        categorys.append(category)
        category = SearchCategoryModel(image: "hotel", name: "Tìm kiếm khách sạn")
        categorys.append(category)
        category = SearchCategoryModel(image: "location", name: "Tìm kiếm địa điểm")
        categorys.append(category)
        category = SearchCategoryModel(image: "trans", name: "Tìm kiếm phương tiện")
        categorys.append(category)
        return categorys
    }
}
