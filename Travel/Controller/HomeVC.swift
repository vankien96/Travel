//
//  HomeVC.swift
//  Travel
//
//  Created by Trương Văn Kiên on 11/16/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var exploreCollectionView: UICollectionView!
    var tours:[Tour] = [Tour]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exploreCollectionView.delegate = self
        exploreCollectionView.dataSource = self
        
        
        exploreCollectionView.register(UINib(nibName: "ExploreViewCell", bundle: nil), forCellWithReuseIdentifier: "ExploreViewCell")
        initData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Khám phá"
    }
    
    func initData(){
        TourService.share.getAllTour { (success, tours) in
            if success{
                DispatchQueue.main.async {
                    self.tours = tours
                    self.exploreCollectionView.reloadData()
                }
            }
        }
        
    }
}




extension HomeVC:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.size.width-32, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailTourVC()
        controller.tour = tours[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}



extension HomeVC:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tours.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreViewCell", for: indexPath) as! ExploreViewCell
        let tour = tours[indexPath.item]
        cell.updateViews(title: tour.title, subTitle: String(tour.price), image: tour.thumbnail,vote: tour.vote)
        
        return cell
    }
}
