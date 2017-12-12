//
//  ProfileEditVC.swift
//  Travel
//
//  Created by Hien Nguyen on 11/30/17.
//  Copyright © 2017 Minori. All rights reserved.
//

import UIKit
import SDWebImage

protocol LogOutDelegate {
    func logout()
}
class ProfileVC: UIViewController {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userBgView: UIImageView!
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var userGenderTxt: UITextField!
    @IBOutlet weak var userAddressTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var btnLogOut: UIButton!
    
    
    
    var user:User!
    var delegate:LogOutDelegate? = nil
    @IBAction func changeProfileImgBtn(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.initUI()
    }
    func initUI(){
        //transparent navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        //edit = false
        usernameTxt.isUserInteractionEnabled = false
        userAddressTxt.isUserInteractionEnabled = false
        userGenderTxt.isUserInteractionEnabled = false
        phoneTxt.isUserInteractionEnabled = false
        //avatar
        self.profileImg.layer.cornerRadius = self.profileImg.bounds.size.height/2
        self.profileImg.layer.masksToBounds = true
        
        //update view
        if user != nil {
            profileImg.sd_setImage(with: URL(string: self.user.userAvatar)!, completed: { (image, error, cache, url) in
                
            })
            usernameTxt.text = user.userName
            userGenderTxt.text = user.gender
            userAddressTxt.text = user.address
            phoneTxt.text = user.phone
        }
    }
    @IBAction func clickOnButtonLogOut(_ sender: Any) {
        self.delegate?.logout()
        self.navigationController?.popViewController(animated: true)
    }
    
}
