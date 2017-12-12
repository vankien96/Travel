//
//  RegisterVC.swift
//  Travel
//
//  Created by Hien Nguyen on 11/30/17.
//  Copyright © 2017 Minori. All rights reserved.
//

import UIKit
protocol  removeFromSuperViewDelegate{
    func removeView(screenName:String)
    func loginSuccess(user:User)
}
class RegisterVC: UIViewController {

    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var effectView: UIVisualEffectView!
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var repasswordView: UIView!
    @IBOutlet weak var containBtncreateAccountView: UIView!
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var repasswordTxt: UITextField!
    var delegate:removeFromSuperViewDelegate? = nil
    
    
    @IBAction func createAccountBtn(_ sender: Any) {
        
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
        if self.delegate != nil {
            delegate?.removeView(screenName: "SignUp")
        }
    }
    func initUI(){
        usernameView.setborder(width: 1, color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), highborder: 10)
        passwordView.setborder(width: 1, color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), highborder: 10)
        repasswordView.setborder(width: 1, color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), highborder: 10)
        repasswordView.setborder(width: 1, color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), highborder: 10)
        
        containBtncreateAccountView.layer.cornerRadius = 10
        registerView.layer.cornerRadius = 10
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
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            self.view.transform = CGAffineTransform(translationX: 0, y: -100)
        }
    }
    
    @objc func handleKeyboardWillHide(_ notification:NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            self.view.transform = .identity
        }
    }
    
    
}

