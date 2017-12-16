//
//  SearchTourViewController.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/11/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import UIKit

class SearchTourViewController: UIViewController {
    @IBOutlet weak var placeCollectionView: UICollectionView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var viewContainSearch: UIView!

    var toursResult:[Tour] = []
    var tours:[Tour]? = nil
    
    var hotelsResult:[Hotel] = []
    var hotels:[Hotel]? = nil
    
    var placesResult:[PlaceTour] = []
    var places:[PlaceTour]? = nil
    
    var transResult:[Transportation] = []
    var trans:[Transportation]? = nil
    
    var textCheck:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        initUI()
        initData()
        txtSearch.addTarget(self, action: #selector(editingChange(sender:)), for: UIControlEvents.editingChanged)
    }
    @objc func editingChange(sender:Any?){
        let text = txtSearch.text!
        self.checkPlaces(text: text as String)
    }
    func initUI(){
        viewContainSearch.layer.cornerRadius = self.viewContainSearch.bounds.size.height/5
        placeCollectionView.delegate = self
        placeCollectionView.dataSource = self
        txtSearch.delegate = self
        self.placeCollectionView.register(UINib.init(nibName: "PlaceCell", bundle: nil), forCellWithReuseIdentifier: "PlaceCell")
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    func initData(){
        if textCheck == "Tour"{
            TourService.share.getAllTour { (success, tours) in
                if success{
                    DispatchQueue.main.async {
                        self.tours = tours
                    }
                }
            }
        }
        if textCheck == "Hotel"{
            HotelService.share.getAllHotel(completion: { (success, hotels) in
                if success{
                    DispatchQueue.main.async {
                        self.hotels = hotels
                    }
                }
            })
        }
        if textCheck == "Place"{
            PlaceDataService.instance.getPlaces(completion: { (success, places) in
                if success{
                    DispatchQueue.main.async {
                        self.places = places
                    }
                }
            })
        }
        if textCheck == "Trans"{
            TransportationService.share.getAllTrans(completion: { (success, trans) in
                if success{
                    DispatchQueue.main.async {
                        self.trans = trans
                    }
                }
            })
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Tìm Kiếm \(self.textCheck)"
    }
    func checkPlaces(text:String){
        if(text == ""){
            if textCheck == "Tour"{
                toursResult = []
            }
            if textCheck == "Hotel"{
                hotelsResult = []
            }
            if textCheck == "Place"{
                placesResult = []
            }
            if textCheck == "Trans"{
                transResult = []
            }
            let range = Range(uncheckedBounds: (0, self.placeCollectionView.numberOfSections))
            let indexSet = IndexSet(integersIn: range)
            self.placeCollectionView.reloadSections(indexSet)
            
            
        }else{
            if textCheck == "Tour"{
                toursResult = []
                if tours != nil{
                    for tour in tours!{
                        if tour.title.lowercased().contains(text.lowercased()){
                            toursResult.append(tour)
                        }
                    }
                }
            }
            if textCheck == "Hotel"{
                hotelsResult = []
                if hotels != nil{
                    for hotel in hotels!{
                        if hotel.name.lowercased().contains(text.lowercased()){
                            self.hotelsResult.append(hotel)
                        }
                    }
                }
            }
            if textCheck == "Place"{
                placesResult = []
                if places != nil{
                    for place in places!{
                        if place.name.lowercased().contains(text.lowercased()){
                            self.placesResult.append(place)
                        }
                    }
                }
            }
            if textCheck == "Trans"{
                transResult = []
                if trans != nil{
                    for tran in trans!{
                        if tran.name.lowercased().contains(text.lowercased()){
                            self.transResult.append(tran)
                        }
                    }
                }
            }
            let range = Range(uncheckedBounds: (0, self.placeCollectionView.numberOfSections))
            let indexSet = IndexSet(integersIn: range)
            self.placeCollectionView.reloadSections(indexSet)
        }
    }
}
extension SearchTourViewController:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.size.width - 32, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if textCheck == "Tour"{
            let tourDetail = DetailTourVC()
            tourDetail.tour = tours?[indexPath.item]
            self.navigationController?.pushViewController(tourDetail, animated: true)
        }
        if textCheck == "Place"{
            let placeDetail = DetailPlaceVC()
            placeDetail.place = placesResult[indexPath.item]
            self.navigationController?.pushViewController(placeDetail, animated: true)
        }
        if textCheck == "Hotel"{
            let placeDetail = DetailPlaceVC()
            placeDetail.hotel = hotelsResult[indexPath.item]
            self.navigationController?.pushViewController(placeDetail, animated: true)
        }
        if textCheck == "Trans"{
            let placeDetail = DetailPlaceVC()
            placeDetail.trans = transResult[indexPath.item]
            self.navigationController?.pushViewController(placeDetail, animated: true)
        }
        
    }
}
extension SearchTourViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if textCheck == "Tour"{
            return toursResult.count
        }
        if textCheck == "Hotel"{
            return hotelsResult.count
        }
        if textCheck == "Place"{
            return placesResult.count
        }
        if textCheck == "Trans"{
            return transResult.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceCell", for: indexPath) as? PlaceCell {
            if textCheck == "Tour"{
                let tour = toursResult[indexPath.row]
                cell.updateViews(image: tour.thumbnail, name: tour.title)
            }
            if textCheck == "Hotel"{
                let hotel = hotelsResult[indexPath.row]
                cell.updateViews(image: hotel.image, name: hotel.name)
            }
            if textCheck == "Place"{
                let place = placesResult[indexPath.row]
                cell.updateViews(image: place.thumbnail, name: place.name)
            }
            if textCheck == "Trans"{
                let tran = transResult[indexPath.row]
                cell.updateViews(image: tran.thumbnail, name: tran.name)
            }
            return cell
        }
        return PlaceCell()
    }
    
}
extension SearchTourViewController:UITextFieldDelegate{
    //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //
    //        let text = textField.text! as NSString
    //        let textAfter = text.replacingCharacters(in: range, with: string)
    //        print(textAfter)
    //        self.checkPlaces(text: textAfter)
    //        return true
    //    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismissKeyboard()
        return true
    }
    
}
