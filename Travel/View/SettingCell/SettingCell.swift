//
//  SettingCell.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/8/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {

    @IBOutlet weak var imgSetting: UIImageView!
    @IBOutlet weak var nameSetting: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateView(image:String,name:String){
        self.imgSetting.image = UIImage(named: image)
        self.nameSetting.text = name
    }
}
