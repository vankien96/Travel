//
//  BookTourVc.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/16/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import UIKit
import Toaster
class BookTourVc: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnFavor: UIButton!
    @IBOutlet weak var btnBook: UIButton!
    @IBOutlet weak var lbSeat: UILabel!
    @IBOutlet weak var stepperSeat: UIStepper!
    @IBOutlet weak var lbMoney: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imgMain: UIImageView!
    @IBOutlet weak var lbStart: UILabel!
    @IBOutlet weak var lbFinish: UILabel!
    
    var isFavorite:Bool = false
    var tour:Tour? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        initUI()
    }
    func initUI(){
        self.navigationController?.navigationBar.isHidden = true
        btnBack.imageView?.tintImageColor(color: UIColor.white)
        if isFavorite{
             btnFavor.imageView?.tintImageColor(color: UIColor(red: 231/255.0, green: 76/255.0, blue: 60/255.0, alpha: 1))
        }
        btnBook.layer.cornerRadius = 5.0
        btnBook.layer.masksToBounds = true
        lbSeat.text = "Số ghế : 1"
        self.stepperSeat.minimumValue = 1
        
        let availableSeat = (tour?.availableSeat)!
        self.stepperSeat.maximumValue = Double(availableSeat)
        
        self.lbTitle.text = (tour?.title)!
        self.lbStart.text = (tour?.startDate)!
        self.lbFinish.text = (tour?.finishDate)!
        self.lbMoney.text = "$ \((tour?.price)!) VNĐ"
    }
    

    @IBAction func clickOnBtnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    @IBAction func clickOnButtonBook(_ sender: Any) {
        let userID = UserDefaults.standard.string(forKey: "userID")
        if userID != nil{
            if userID! != ""{
                BookedTourService.share.setBookTour(userID: userID!, tourID: (tour?.tourID)!, completion: { (success) in
                    if success{
                        DispatchQueue.main.async {
                            let toast = Toast(text: "Đặt vé thành công", delay: 0, duration: 1)
                            toast.show()
                            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.doBack), userInfo: nil, repeats: true)
                        }
                    }else{
                        self.showAlert(message: "Bạn đã đặt tour này rồi hoặc lỗi mạng")
                    }
                })
            }else{
                self.showAlert(message: "Vui lòng đăng nhập để đặt vé")
            }
        }else{
            self.showAlert(message: "Vui lòng đăng nhập để đặt vé")
        }
    }
    @objc func doBack(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func didChangeStepper(_ sender: Any) {
        let value = Int(stepperSeat.value)
        self.lbSeat.text = "Số ghế : \(value)"
        let price = (tour?.price)!
        let totalPrice = price*Int(value)
        self.lbMoney.text = "$ \(totalPrice) VNĐ"
    }
}
