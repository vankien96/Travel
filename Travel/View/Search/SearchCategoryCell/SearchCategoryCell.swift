//
//  SearchCategoryCell.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/11/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import UIKit

class SearchCategoryCell: UITableViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbSearchCate: UILabel!
    @IBOutlet weak var viewContainImg: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        viewContainImg.layer.cornerRadius = viewContainImg.bounds.size.height/5
        viewContainImg.layer.masksToBounds = true
    }
    func updateView(image:String,name:String){
        imgIcon.image = UIImage(named: image)
        lbSearchCate.text = name
    }
    
}
