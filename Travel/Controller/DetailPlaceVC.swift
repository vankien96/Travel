//
//  DetailPlaceVC.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/12/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import UIKit
import ImageSlideshow
import SDWebImage

class DetailPlaceVC: UIViewController {

    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var textViewDetail: UITextView!
    @IBOutlet weak var imgDetial: UIImageView!
    
    var place:PlaceTour? = nil
    var hotel:Hotel? = nil
    var trans:Transportation? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
    }
    func initData(){
        if let placeInfo = place{
            let imageArrString:[String] = [placeInfo.thumbnail,placeInfo.photo]
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
            self.lbLocation.text = placeInfo.address
            self.textViewDetail.text = placeInfo.longDes
        }
        if let hotelInfo = hotel{
            let imageArrString:[String] = [hotelInfo.image]
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
            self.lbLocation.text = hotelInfo.address
            self.textViewDetail.text = hotelInfo.detail
        }
        if let transInfo = trans{
            let imageArrString:[String] = [transInfo.thumbnail,transInfo.image]
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
            self.lbLocation.text = transInfo.name
            self.textViewDetail.text = ""
            self.imgDetial.image = UIImage(named: "trans")
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.textViewDetail.setContentOffset(CGPoint.zero, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
