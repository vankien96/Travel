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
    
    var place:PlaceTour? = nil
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
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.textViewDetail.setContentOffset(CGPoint.zero, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
