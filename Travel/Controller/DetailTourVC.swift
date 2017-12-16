//
//  DetailTourVC.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/8/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import UIKit
import ImageSlideshow
import SDWebImage
import Toaster


class DetailTourVC: UIViewController {
    
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var vote1: UIImageView!
    @IBOutlet weak var vote2: UIImageView!
    @IBOutlet weak var vote3: UIImageView!
    @IBOutlet weak var vote4: UIImageView!
    @IBOutlet weak var vote5: UIImageView!
    @IBOutlet weak var lbMoney: UILabel!
    @IBOutlet weak var lbHotel: UILabel!
    @IBOutlet weak var lbTrans: UILabel!
    @IBOutlet weak var lbSeat: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var btnFavor: UIButton!
    @IBOutlet weak var btnBook: UIButton!
    @IBOutlet weak var viewContainFavor: UIView!
    @IBOutlet weak var viewContainBook: UIView!
    @IBOutlet weak var imgHeart: UIImageView!
    @IBOutlet weak var imgCart: UIImageView!
    
    
    var tour:Tour? = nil
    var place:PlaceTour? = nil
    var hotel:Hotel? = nil
    var trans:Transportation? = nil
    var isFavorite:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }
    func initUI(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        slideShow.addGestureRecognizer(gestureRecognizer)
        
        //Config UI
        viewContainBook.layer.cornerRadius = viewContainBook.bounds.size.height/10
        viewContainBook.layer.masksToBounds = true
        viewContainFavor.layer.cornerRadius = viewContainFavor.bounds.size.height/10
        viewContainFavor.layer.masksToBounds = true
        
        self.btnFavor.isUserInteractionEnabled = false
        self.btnBook.isUserInteractionEnabled = false
        
    }
    func initData(){
        if tour != nil{
            let placeID = tour?.placeID
            PlaceDataService.instance.getPlace(placeID: placeID!, completion: { (success, place) in
                if success{
                    DispatchQueue.main.async {
                        self.place = place
                        self.updateView()
                    }
                }
            })
            HotelService.share.getHotel(hotelID: (tour?.hotelID)!, completion: { (success, hotel) in
                if success{
                    DispatchQueue.main.async {
                        self.hotel = hotel
                        self.lbHotel.text = (hotel?.name)!
                    }
                }
            })
            TransportationService.share.getTransportation(transportationID: (tour?.transportationID)!, completion: { (success, trans) in
                DispatchQueue.main.async {
                    self.trans = trans
                    self.lbTrans.text = self.trans?.name
                }
            })
        }
    }
    func updateView(){
        let imageArrString:[String] = [(place?.thumbnail)!,(place?.photo)!,(self.tour?.thumbnail)!]
        var imageArr:[InputSource] = []
        for urlString in imageArrString{
            SDWebImageManager.shared().imageDownloader?.downloadImage(with: URL(string: urlString), options: SDWebImageDownloaderOptions.continueInBackground, progress: nil, completed: { (image, data, error, success) in
                if success && error == nil{
                    DispatchQueue.main.async {
                        imageArr.append(ImageSource(image: image!))
                        self.slideShow.setImageInputs(imageArr)
                    }
                }
            })
        }
        self.lbSeat.text = "Còn \((tour?.availableSeat)!) chỗ"
        self.lbTime.text = "\((tour?.startDate)!)->\((tour?.finishDate)!)"
        self.lbMoney.text = "\((tour?.price)!) VNĐ"
        self.lbLocation.text = "\((tour?.title)!)"
        
        
        //set action for lb place
        lbLocation.isUserInteractionEnabled = true
        let tapPlace = UITapGestureRecognizer(target: self, action: #selector(tapLbLocation(sender:)))
        tapPlace.numberOfTapsRequired = 1
        tapPlace.numberOfTouchesRequired = 1
        lbLocation.addGestureRecognizer(tapPlace)
        
        
        //set action for lbHotel
        lbHotel.isUserInteractionEnabled = true
        let tapHotel = UITapGestureRecognizer(target: self, action: #selector(tapLbHotel(sender:)))
        tapHotel.numberOfTapsRequired = 1
        tapHotel.numberOfTouchesRequired = 1
        lbHotel.addGestureRecognizer(tapHotel)
        
        //set action for trans
        lbTrans.isUserInteractionEnabled = true
        let tapTrans = UITapGestureRecognizer(target: self, action: #selector(tapLbTrans(sender:)))
        tapTrans.numberOfTapsRequired = 1
        tapTrans.numberOfTouchesRequired = 1
        lbTrans.addGestureRecognizer(tapTrans)
        
        
        let vote = (tour?.vote)!
        switch vote {
        case 5:
            vote5.image = UIImage(named: "voted")
            vote4.image = UIImage(named: "voted")
            vote3.image = UIImage(named: "voted")
            vote2.image = UIImage(named: "voted")
            vote1.image = UIImage(named: "voted")
            break
        case 4:
            vote5.image = UIImage(named: "vote")
            vote4.image = UIImage(named: "voted")
            vote3.image = UIImage(named: "voted")
            vote2.image = UIImage(named: "voted")
            vote1.image = UIImage(named: "voted")
            break
        case 3:
            vote5.image = UIImage(named: "vote")
            vote4.image = UIImage(named: "vote")
            vote3.image = UIImage(named: "voted")
            vote2.image = UIImage(named: "voted")
            vote1.image = UIImage(named: "voted")
            break
        case 2:
            vote5.image = UIImage(named: "vote")
            vote4.image = UIImage(named: "vote")
            vote3.image = UIImage(named: "vote")
            vote2.image = UIImage(named: "voted")
            vote1.image = UIImage(named: "voted")
            break
        case 1:
            vote5.image = UIImage(named: "vote")
            vote4.image = UIImage(named: "vote")
            vote3.image = UIImage(named: "vote")
            vote2.image = UIImage(named: "vote")
            vote1.image = UIImage(named: "voted")
            break
        default:
            vote5.image = UIImage(named: "vote")
            vote4.image = UIImage(named: "vote")
            vote3.image = UIImage(named: "vote")
            vote2.image = UIImage(named: "vote")
            vote1.image = UIImage(named: "vote")
            break
        }
        self.btnFavor.isUserInteractionEnabled = true
        self.btnBook.isUserInteractionEnabled = true
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let favoriteTourOfThisUser = appdelegate.favoriteTours
        if favoriteTourOfThisUser.count != 0{
            print("favorite tour available")
            for item in favoriteTourOfThisUser{
                if item.tourID == (self.tour?.tourID)!{
                    self.imgHeart.image = UIImage(named: "heart_red")
                    self.isFavorite = true
                }
            }
        }
    }
    @objc func didTap() {
        slideShow.presentFullScreenController(from: self)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Chi tiết"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Did Tap in any label
    @objc func tapLbLocation(sender:Any){
        let placeDetail = DetailPlaceVC()
        placeDetail.place = self.place
        self.navigationController?.pushViewController(placeDetail, animated: true)
    }
    @objc func tapLbHotel(sender:Any){
        let placeDetail = DetailPlaceVC()
        placeDetail.hotel = self.hotel
        self.navigationController?.pushViewController(placeDetail, animated: true)
    }
    @objc func tapLbTrans(sender:Any){
        let placeDetail = DetailPlaceVC()
        placeDetail.trans = self.trans
        self.navigationController?.pushViewController(placeDetail, animated: true)
    }
    @IBAction func clickOnButtonFavorite(_ sender: Any) {
        let userID = UserDefaults.standard.string(forKey: "userID")
        if userID != nil{
            if userID! != ""{
                if !isFavorite{
                    print("add favorite")
                    self.btnFavor.isUserInteractionEnabled = false
                    FavoriteTourService.share.setFavorite(userID: userID!, tourID: (self.tour?.tourID)!, completion: { (success) in
                        if success {
                            print("success")
                            DispatchQueue.main.async {
                                let toast = Toast(text: "Thêm vào yêu thích thành công", delay: 0, duration: 0.5)
                                toast.show()
                                let appdelegate = UIApplication.shared.delegate as! AppDelegate
                                appdelegate.getFavorTours()
                                UIView.transition(with: self.imgHeart, duration: 0.2, options: .transitionCrossDissolve, animations: {
                                    self.imgHeart.image = UIImage(named: "heart_red")
                                    self.btnFavor.isUserInteractionEnabled = true
                                    self.isFavorite = true
                                }, completion: nil)
                            }
                        }
                    })
                }else{
                    //delete favorite
                    print("delete favorite")
                    self.btnFavor.isUserInteractionEnabled = false
                    FavoriteTourService.share.deleteFavorite(userID: userID!, tourID: (self.tour?.tourID)!, completion: { (success) in
                        if success{
                            print("success")
                            DispatchQueue.main.async {
                                let toast = Toast(text: "Xóa yêu thích thành công", delay: 0, duration: 0.5)
                                toast.show()
                                let appdelegate = UIApplication.shared.delegate as! AppDelegate
                                appdelegate.getFavorTours()
                                UIView.transition(with: self.imgHeart, duration: 0.2, options: .transitionCrossDissolve, animations: {
                                    self.imgHeart.image = UIImage(named: "heart")
                                    self.btnFavor.isUserInteractionEnabled = true
                                    self.isFavorite = false
                                }, completion: nil)
                            }
                        }
                    })
                }
            }
        }
    }
    @IBAction func clickOnButtonBook(_ sender: Any) {
        let bookVc = BookTourVc()
        bookVc.isFavorite = self.isFavorite
        bookVc.tour = self.tour
        self.navigationController?.pushViewController(bookVc, animated: true)
    }
}
