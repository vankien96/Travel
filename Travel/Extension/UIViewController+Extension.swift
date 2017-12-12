//
//  UIView+Extension.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/7/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import UIKit
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func showAlert(message:String){
        let alert = UIAlertController(title: "Chú ý", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
            
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
