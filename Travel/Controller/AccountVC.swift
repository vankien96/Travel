//
//  AccountVC.swift
//  Travel
//
//  Created by Trương Văn Kiên on 11/16/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import UIKit

class AccountVC: UIViewController{

    @IBOutlet weak var tbvAccount: UITableView!
    let settingArr:[Setting] = Setting.getSetting()
    var userCurrent:User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        tbvAccount.dataSource = self
        tbvAccount.delegate = self
        let nib = UINib(nibName: "DetailAccountTVC", bundle: nil)
        tbvAccount.register(nib, forCellReuseIdentifier: "DetailAccountTVC")
        tbvAccount.register(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: "SettingCell")
    }
    func initData(){
        let userID = UserDefaults.standard.string(forKey: "userID")
        if(userID != nil){
            if userID! == ""{
                
            }else{
                AuthService.instance.getUserInfo(userID: userID!, completion: { (success, user) in
                    if success{
                        DispatchQueue.main.async {
                            self.userCurrent = user
                            self.tbvAccount.reloadData()
                        }
                    }
                })
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Tài khoản"
    }
}

// Mark: - UITableViewDatasource
extension AccountVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }else{
            return settingArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailAccountTVC", for: indexPath) as? DetailAccountTVC{
                if userCurrent != nil{
                    cell.name = (userCurrent?.userName)!
                    cell.imageAvatar = (userCurrent?.userAvatar)!
                }else{
                    cell.imgAvatar.image = UIImage(named: "avatar")!
                    cell.name = "Đăng nhập"
                }
                return cell
            }else{
                return UITableViewCell()
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as? SettingCell{
                
                let settingItem:Setting = settingArr[indexPath.item]
                cell.updateView(image: settingItem.imageName, name: settingItem.name)
                return cell
            }else{
                return UITableViewCell()
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        }
        return 50
    }
    
    
    
}
// Mark: - UITableViewDelegate
extension AccountVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            cell.setSelected(false, animated: true)
        }
        
        if(indexPath.section == 0){
            if(UserDefaults.standard.string(forKey: "userID") == nil || UserDefaults.standard.string(forKey: "userID") == ""){
                let viewController = SplashVC()
                viewController.delegate = self
                self.navigationController?.pushViewController(viewController, animated: true)
            }else{
                let viewController = ProfileVC()
                viewController.user = userCurrent
                viewController.delegate = self
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        
    }
}
extension AccountVC:LoginDelegate{
    func loginSuccess(user: User) {
        self.userCurrent = user
        self.tbvAccount.reloadData()
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.getFavorTours()
    }
}
extension AccountVC:LogOutDelegate{
    func logout() {
        UserDefaults.standard.set("", forKey: "userID")
        userCurrent = nil
        self.tbvAccount.reloadData()
    }
    
    
}
