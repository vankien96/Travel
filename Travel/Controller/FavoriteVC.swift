//
//  FavoriteVC.swift
//  Travel
//
//  Created by Trương Văn Kiên on 11/22/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import UIKit

class FavoriteVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Yêu thích"
    }

}
