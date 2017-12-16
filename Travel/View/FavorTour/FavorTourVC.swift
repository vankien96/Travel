//
//  FavorTour.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/12/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import UIKit

class FavorTourVC: UIViewController {
    
    @IBOutlet weak var favorCollection: UICollectionView!
    var tours:[Tour] = []
    var favorTour:[FavoriteTour] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        favorCollection.delegate = self
        favorCollection.dataSource = self
        favorCollection.register(UINib(nibName: "PlaceCell", bundle: nil), forCellWithReuseIdentifier: "PlaceCell")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.string(forKey: "userID") == nil || UserDefaults.standard.string(forKey: "userID") == ""{
            tours = []
            favorTour = []
            self.favorCollection.reloadData()
            return
        }
        initData()
    }
    func initData(){
        print("init data")
        tours = []
        favorTour = []
        let userID = UserDefaults.standard.string(forKey: "userID")
        FavoriteTourService.share.getFavoriteTour(userID: userID!) { (success, favorTours) in
            if success{
                DispatchQueue.main.async {
                    //get tour info
                    self.favorTour = favorTours
                    TourService.share.getAllTour { (success, tours) in
                        if success{
                            DispatchQueue.main.async {
                                for id in self.favorTour{
                                    for tour in tours {
                                        if tour.tourID == id.tourID{
                                            self.tours.append(tour)
                                        }
                                    }
                                }
                                self.favorCollection.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }

}
extension FavorTourVC:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width-32, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if tours.count > indexPath.item{
            let tourDetail = DetailTourVC()
            tourDetail.tour = tours[indexPath.item]
            self.navigationController?.pushViewController(tourDetail, animated: true)
        }
    }
}
extension FavorTourVC:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorTour.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceCell", for: indexPath) as! PlaceCell
        let tour = tours[indexPath.item]
        cell.updateViews(image: tour.thumbnail, name: tour.title)
        return cell
    }
}
