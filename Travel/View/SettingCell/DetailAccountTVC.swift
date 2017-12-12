//
//  DetailAccountTVC.swift
//  Travel
//
//  Created by Trương Văn Kiên on 11/22/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import UIKit

class DetailAccountTVC: UITableViewCell {

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbSignIn: UILabel!
    
    var imageAvatar:String = ""{
        didSet{
            if let url = URL(string: imageAvatar){
                DispatchQueue.global(qos: .userInitiated).async {
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.imgAvatar.image = UIImage(data: data!)
                    }
                }
            }
        }
    }
    var name:String = ""{
        didSet{
            if name != ""{
                lbSignIn.text = name
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgAvatar.layer.cornerRadius = imgAvatar.bounds.size.height/2
        imgAvatar.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
