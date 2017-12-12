//
//  SearchVC.swift
//  Travel
//
//  Created by Trương Văn Kiên on 12/11/17.
//  Copyright © 2017 VanKien. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    @IBOutlet weak var tableSearchCategory: UITableView!
    
    var category:[SearchCategoryModel] = [SearchCategoryModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }
    func initUI(){
        tableSearchCategory.delegate = self
        tableSearchCategory.dataSource = self
        tableSearchCategory.register(UINib(nibName: "SearchCategoryCell", bundle: nil), forCellReuseIdentifier: "SearchCategoryCell")
    }
    func initData(){
        category = SearchCategoryModel.getAllCategory()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Tìm kiếm"
        
    }
}
extension SearchVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
        let searchTour = SearchTourViewController()
        if indexPath.row == 0 {
            searchTour.textCheck = "Tour"
        }
        if indexPath.row == 1{
            searchTour.textCheck = "Hotel"
        }
        if indexPath.row == 2{
            searchTour.textCheck = "Place"
        }
        if indexPath.row == 3{
            searchTour.textCheck = "Trans"
        }
        self.navigationController?.pushViewController(searchTour, animated: true)
    }
}
extension SearchVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCategoryCell", for: indexPath) as! SearchCategoryCell
        let cellData = category[indexPath.item]
        cell.updateView(image: cellData.image, name: cellData.name)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
