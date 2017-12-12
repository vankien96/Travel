//
//  LoginVC.swift
//  Travel
//
//  Created by Hien Nguyen on 11/30/17.
//  Copyright © 2017 Minori. All rights reserved.
//

import UIKit
class LoginVC: UIViewController {
    
    
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var effectView: UIVisualEffectView!
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var containBtnLoginView: UIView!
    var delegate:removeFromSuperViewDelegate? = nil
    
    @IBAction func loginBtn(_ sender: Any) {
        if usernameTxt.text == "" || passwordTxt.text == ""{
            self.showAlert(message: "Vui lòng nhập tài khoản và mật khẩu")
        }else{
            AuthService.instance.checkLogin(username: usernameTxt.text!, password: passwordTxt.text!, completion: { (success, user) in
                if success{
                    DispatchQueue.main.async {
                        UserDefaults.standard.set((user?.userID)!, forKey: "userID")
                        self.delegate?.loginSuccess(user: user!)
                    }
                }else{
                    self.showAlert(message: "Tài khoản hoặc mật khẩu không đúng")
                }
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        addNotification()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapToBack(tap:)))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        self.effectView.addGestureRecognizer(tap)
        self.effectView.alpha = 0
    }
    @objc func tapToBack(tap:UIGestureRecognizer){
        if delegate != nil{
            delegate?.removeView(screenName: "SignIn")
        }
    }
    func initUI(){
        usernameView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        usernameView.layer.borderWidth = 1
        usernameView.layer.cornerRadius = 10
        passwordView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        passwordView.layer.borderWidth = 1
        passwordView.layer.cornerRadius = 10
        loginView.layer.cornerRadius = 10
        
        containBtnLoginView.layer.cornerRadius = containBtnLoginView.bounds.size.height/5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    @objc func handleKeyboardWillShow(_ notification:NSNotification) {
        self.view.transform = CGAffineTransform(translationX: 0, y: -50)
    }
    
    @objc func handleKeyboardWillHide(_ notification:NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            self.view.transform = .identity
        }
    }

    
}
