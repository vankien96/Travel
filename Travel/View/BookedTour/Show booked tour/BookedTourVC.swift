//
//  BookedTourVC.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/12/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import UIKit

class BookedTourVC: UIViewController {

    @IBOutlet weak var bookedCollection: UICollectionView!
    
    var bookedTour:[BookedTour] = []
    var tours:[Tour] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.string(forKey: "userID") == nil || UserDefaults.standard.string(forKey: "userID") == ""{
            tours = []
            bookedTour = []
            bookedCollection.reloadData()
            return
        }
        initData()
    }
    func initUI(){
        bookedCollection.delegate = self
        bookedCollection.dataSource = self
        bookedCollection.register(UINib(nibName: "PlaceCell", bundle: nil), forCellWithReuseIdentifier: "PlaceCell")
    }
    func initData(){
        tours = []
        bookedTour = []
        let userID = UserDefaults.standard.string(forKey: "userID")
        BookedTourService.share.getBookedTour(userID: userID!) { (success, bookedTour) in
            if success{
                DispatchQueue.main.async {
                    self.bookedTour = bookedTour
                    TourService.share.getAllTour(completion: { (completed, tours) in
                        if completed{
                            DispatchQueue.main.async {
                                for id in bookedTour{
                                    for tour in tours{
                                        if tour.tourID == id.tourID{
                                            self.tours.append(tour)
                                        }
                                    }
                                }
                                self.bookedCollection.reloadData()
                            }
                        }
                    })
                }
            }
        }
    }
}
extension BookedTourVC:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width-32, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if tours.count > indexPath.item{
            let tour = tours[indexPath.item]
            let detailTour = DetailTourVC()
            detailTour.tour = tour
            self.navigationController?.pushViewController(detailTour, animated: true)
        }
    }
}
extension BookedTourVC:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tours.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceCell", for: indexPath) as! PlaceCell
        let tour = tours[indexPath.item]
        cell.updateViews(image: tour.thumbnail, name: tour.title)
        return cell
    }
}
