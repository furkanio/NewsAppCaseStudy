//
//  VC_NewsDetail.swift
//  NewsAppCaseStudy
//
//  Created by Furkan Yıldız on 28.03.2022.
//

import UIKit

class VC_FavoriteNews: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var coreDataModel = [New]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        coreDataModel = DAL.getAllData() ?? []
        tableView.reloadData()
    }
    
    func prepareView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TVC_NewsList")
    }
}

extension VC_FavoriteNews : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = coreDataModel[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("TVC_NewsList", owner: self, options: nil)?.first as! TVC_NewsList
        cell.bindDataFav (data: c)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.shared.segueFavToDetail, sender: indexPath.row)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.shared.segueFavToDetail{
            let newsDetail = segue.destination as! VC_NewDetail
            newsDetail.getFavData = coreDataModel[sender as! Int]

        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                 
                if editingStyle == .delete
                {
                    DAL.deleteFunc(data: coreDataModel[indexPath.row])
                    coreDataModel = DAL.getAllData() ?? []
                    tableView.reloadData()
                }
            }
    
    
}
