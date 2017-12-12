//
//  SplashVC.swift
//  Travel
//
//  Created by Hien Nguyen on 11/30/17.
//  Copyright © 2017 Minori. All rights reserved.
//

import UIKit
protocol LoginDelegate {
    func loginSuccess(user:User)
}
class SplashVC: UIViewController {
    
    @IBOutlet weak var containBtnLoginView: UIView!
    @IBOutlet weak var containBtnSignupView: UIView!
    var delegate:LoginDelegate? = nil
    
    
    let registerController = RegisterVC()
    let loginController = LoginVC()
    
    @IBAction func loginBtn(_ sender: Any) {
        loginController.delegate = self
        self.addChildViewController(loginController)
        loginController.view.frame = self.view.bounds
        self.view.addSubview(loginController.view)
        loginController.didMove(toParentViewController: self)//di chuyen tren chinh man hinh` main
        loginController.view.alpha = 0.0
        loginController.view.transform = CGAffineTransform(translationX: 0, y: 300)//vi tri ban dau
        UIView.animate(withDuration: 0.5, animations: {
            self.loginController.effectView.alpha = 0.7
            self.loginController.view.alpha = 1
            self.loginController.view.transform  = .identity
            
            self.view.layoutIfNeeded()
        }) { (true) in
            
        }
        
    }
    @IBAction func signupBtn(_ sender: Any) {
        self.addChildViewController(registerController)
        registerController.delegate = self
        registerController.view.frame = self.view.bounds
        self.view.addSubview(registerController.view)
        registerController.didMove(toParentViewController: self)//di chuyen tren chinh man hinh` main
        registerController.view.alpha = 0.0
        registerController.view.transform = CGAffineTransform(translationX: 0, y: 300)//vi tri ban dau
        UIView.animate(withDuration: 0.5, animations: {
            self.registerController.effectView.alpha = 0.7
            self.registerController.view.alpha = 1
            self.registerController.view.transform  = .identity
            self.view.layoutIfNeeded()
        }) { (true) in
            
        }
    }
    
    @IBAction func clickOnBtnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        initUI()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func initUI(){
        containBtnLoginView.layer.cornerRadius = containBtnLoginView.bounds.size.height/5
        containBtnLoginView.layer.masksToBounds = true
        containBtnLoginView.clipsToBounds = true
        containBtnSignupView.layer.cornerRadius = containBtnSignupView.bounds.size.height/5
        containBtnSignupView.layer.masksToBounds = true
        containBtnSignupView.clipsToBounds = true
        //hide navigation
        //self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
}



extension SplashVC:removeFromSuperViewDelegate{
    func loginSuccess(user: User) {
        self.delegate?.loginSuccess(user: user)
        self.navigationController?.popViewController(animated: true)
    }
    
    func removeView(screenName:String) {
        print("dismiss")
        if screenName == "SignUp"{
            UIView.animate(withDuration: 0.5, animations: {
                self.registerController.effectView.alpha = 0.0
                self.registerController.view.alpha = 0
                self.registerController.view.transform  = CGAffineTransform(translationX: 0, y: 300)
            }) { (true) in
                self.registerController.view.removeFromSuperview()
                self.registerController.view.transform = .identity
            }
        }
        if screenName == "SignIn"{
            UIView.animate(withDuration: 0.5, animations: {
                self.loginController.effectView.alpha = 0.0
                self.loginController.view.alpha = 0
                self.loginController.view.transform  = CGAffineTransform(translationX: 0, y: 300)
            }) { (true) in
                self.loginController.view.removeFromSuperview()
                self.loginController.view.transform = .identity
            }
        }
    }
    
    
}
