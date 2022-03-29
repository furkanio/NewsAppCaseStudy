//
//  ViewController.swift
//  NewsAppCaseStudy
//
//  Created by Furkan Yıldız on 28.03.2022.
//

import UIKit

class VC_NewsList: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var counterPage = 2
    var isLoading = false
    
    var searchController = UISearchController()
    private var searchHelper : SearchHelper?

    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var newsArticle : [Article] = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareView()
    }
    
    func prepareView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TVC_NewsList")
        fetchBesiktasNews()
        searchBarCreate()
        prepareSearchHelper()
    }
    
    func searchBarCreate(){
        searchController.searchBar.placeholder = "Search Album"
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        searchController.searchBar.isHidden = false
    }
    
    private func fetchBesiktasNews(){
        APIService.shared.fetchBesiktasData(page: 1){[weak self] (NewsResponse, error) in
            if error == nil {
                guard  let news = NewsResponse?.articles else {return}
                print("Current Page : 1")
                self?.newsArticle = news
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }else{
                
            }
        }
    }
    
    func prepareSearchHelper () {
        searchHelper = SearchHelper(interval: 0.4, handler: { text in
            
            APIService.shared.fetchSearchData(query: text){[weak self] (NewsResponse, error) in
                if error == nil && text != " " {
                self?.newsArticle.removeAll()
                self?.newsArticle.append(contentsOf: NewsResponse!.articles)
                self!.tableView.reloadData()
                }else {
                    
                }
    }
        })
    }
}

extension VC_NewsList: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticle.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = newsArticle[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("TVC_NewsList", owner: self, options: nil)?.first as! TVC_NewsList
        cell.bindData(data: c)
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.shared.segueListToDetail, sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.shared.segueListToDetail{
            let newsDetail = segue.destination as! VC_NewDetail
            newsDetail.getModel = newsArticle[sender as! Int]

        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == newsArticle.count - 1 && isSearchBarEmpty{
           scrollData()
        }
    }
    
    
    func scrollData(){
        self.isLoading = true
        APIService.shared.fetchBesiktasData(page: counterPage) {[weak self] (NewsResponse,error) in
            if error == nil {
                DispatchQueue.main.async {
                    sleep(2)
                    let start = self!.newsArticle.count
                    let end = start
                    if end < 100 {
                        guard  let newData = NewsResponse?.articles else {return}
                        print("Current Page : \(self!.counterPage)")
                        self?.newsArticle.append(contentsOf: newData)
                        self?.counterPage += 1
                        self!.isLoading = false
                        self!.tableView.reloadData()
                                    }
                    
                }
            }else{
            }
                    }
    }
}

extension VC_NewsList : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            searchHelper?.handleTyping(text: searchText)

            print(searchText)

        }
        
    }
}

extension VC_NewsList: UISearchBarDelegate {
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchController.isActive = false
        if let searchText = searchBar.text {
            searchHelper?.handleTyping(text: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        
        if isSearchBarEmpty  {
            fetchBesiktasNews()

        }

    }
    
    
}

