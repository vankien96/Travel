//
//  PlaceCell.swift
//  Travel
//
//  Created by Hien Nguyen on 11/30/17.
//  Copyright © 2017 Minori. All rights reserved.
//

import UIKit

class PlaceCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        placeImage.layer.cornerRadius = placeImage.bounds.size.height/10
        placeImage.layer.masksToBounds = true
    }
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    
    func updateViews(image:String,name:String) {
        placeImage.sd_setImage(with: URL(string: image)!) { (image, eror, cache, url) in
            
        }
        placeName.text = name

    }

}
