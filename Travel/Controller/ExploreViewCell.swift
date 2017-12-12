//
//  ExploreViewCell.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/8/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import UIKit
import SDWebImage
class ExploreViewCell: UICollectionViewCell {
    @IBOutlet weak var imgMain: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtSubTitle: UILabel!
    @IBOutlet weak var vote1: UIImageView!
    @IBOutlet weak var vote2: UIImageView!
    @IBOutlet weak var vote3: UIImageView!
    @IBOutlet weak var vote4: UIImageView!
    @IBOutlet weak var vote5: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgMain.layer.cornerRadius = self.imgMain.bounds.size.height/10
        imgMain.layer.masksToBounds = true
    }
    func updateViews(title:String,subTitle:String,image:String,vote:Int) {
        txtTitle.text = title
        txtSubTitle.text = subTitle + " VNĐ"
        let url = URL(string: image)
        imgMain.sd_addActivityIndicator()
        imgMain.sd_setImage(with: url!) { (image, error, type, url) in
            
        }
        switch vote {
        case 5:
            vote5.image = UIImage(named: "voted")
            vote4.image = UIImage(named: "voted")
            vote3.image = UIImage(named: "voted")
            vote2.image = UIImage(named: "voted")
            vote1.image = UIImage(named: "voted")
            break
        case 4:
            vote5.image = UIImage(named: "vote")
            vote4.image = UIImage(named: "voted")
            vote3.image = UIImage(named: "voted")
            vote2.image = UIImage(named: "voted")
            vote1.image = UIImage(named: "voted")
            break
        case 3:
            vote5.image = UIImage(named: "vote")
            vote4.image = UIImage(named: "vote")
            vote3.image = UIImage(named: "voted")
            vote2.image = UIImage(named: "voted")
            vote1.image = UIImage(named: "voted")
            break
        case 2:
            vote5.image = UIImage(named: "vote")
            vote4.image = UIImage(named: "vote")
            vote3.image = UIImage(named: "vote")
            vote2.image = UIImage(named: "voted")
            vote1.image = UIImage(named: "voted")
            break
        case 1:
            vote5.image = UIImage(named: "vote")
            vote4.image = UIImage(named: "vote")
            vote3.image = UIImage(named: "vote")
            vote2.image = UIImage(named: "vote")
            vote1.image = UIImage(named: "voted")
            break
        default:
            vote5.image = UIImage(named: "vote")
            vote4.image = UIImage(named: "vote")
            vote3.image = UIImage(named: "vote")
            vote2.image = UIImage(named: "vote")
            vote1.image = UIImage(named: "vote")
            break
        }
    }

}
