//
//  FavoriteVC.swift
//  Travel
//
//  Created by Trương Văn Kiên on 11/22/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import UIKit

class FavoriteVC: UIViewController {
    @IBOutlet weak var btnFavor: UIButton!
    @IBOutlet weak var btnBooked: UIButton!
    @IBOutlet weak var mainScroll: UIScrollView!
    let favorVC = FavorTourVC()
    let bookedVC = BookedTourVC()
    var lastpage = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    func initUI(){
        mainScroll.translatesAutoresizingMaskIntoConstraints = true
        mainScroll.contentSize = CGSize(width: UIScreen.main.bounds.width*2, height: 0)
        mainScroll.contentOffset = CGPoint(x: 0, y: 0)
        mainScroll.showsVerticalScrollIndicator = false
        mainScroll.showsHorizontalScrollIndicator = false
        mainScroll.isPagingEnabled = true
//        mainScroll.isScrollEnabled = false
        mainScroll.bounces = false
        mainScroll.scrollsToTop = false
        mainScroll.delegate = self
        
        favorVC.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: mainScroll.bounds.size.height)
        mainScroll.addSubview(favorVC.view)
        self.addChildViewController(favorVC)
        
        bookedVC.view.frame = CGRect(x: self.view.bounds.width, y: 0, width: self.view.bounds.width, height: mainScroll.bounds.height)
        mainScroll.addSubview(bookedVC.view)
        self.addChildViewController(bookedVC)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Yêu thích"
    }
    @IBAction func clickOnBtnFavor(_ sender: Any) {
        if(lastpage == 1){
            btnFavor.backgroundColor = UIColor(red: 245/255.0, green: 147/255.0, blue: 48/255.0, alpha: 1)
            btnBooked.backgroundColor = UIColor(red: 102/255.0, green: 138/255.0, blue: 67/255.0, alpha: 1)
            UIView.animate(withDuration: 0.25) {
                self.mainScroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
            lastpage = 0
        }
    }
    @IBAction func clickOnBtnBooked(_ sender: Any) {
        if lastpage == 0{
            btnBooked.backgroundColor = UIColor(red: 245/255.0, green: 147/255.0, blue: 48/255.0, alpha: 1)
            btnFavor.backgroundColor = UIColor(red: 102/255.0, green: 138/255.0, blue: 67/255.0, alpha: 1)
            UIView.animate(withDuration: 0.25) {
                self.mainScroll.setContentOffset(CGPoint(x: UIScreen.main.bounds.width, y: 0), animated: true)
            }
            lastpage = 1
        }
    }
    
}
extension FavoriteVC:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width);
        if page == 0 {
            btnFavor.backgroundColor = UIColor(red: 245/255.0, green: 147/255.0, blue: 48/255.0, alpha: 1)
            btnBooked.backgroundColor = UIColor(red: 102/255.0, green: 138/255.0, blue: 67/255.0, alpha: 1)
        }else{
            btnBooked.backgroundColor = UIColor(red: 245/255.0, green: 147/255.0, blue: 48/255.0, alpha: 1)
            btnFavor.backgroundColor = UIColor(red: 102/255.0, green: 138/255.0, blue: 67/255.0, alpha: 1)
        }
        lastpage = page
    }
}
