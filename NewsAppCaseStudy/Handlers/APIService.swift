//
//  APIService.swift
//  NewsAppCaseStudy
//
//  Created by Furkan Yıldız on 28.03.2022.
//
// https://newsapi.org/v2/everything?q=besiktas&amp;page=1&amp;apiKey=90f78b5e459f4557a6d285161db89
// https://newsapi.org/v2/everything?q=bitcoin&apiKey=7c536964978440e98dddb93c96afcd9a



import Foundation

class APIService{
    static var shared = APIService()
   
    func fetchBesiktasData(page:Int?,completion: @escaping (_ data : NewsResponse?, _ error: Error?)-> Void){
        guard let pageNumber = page else {return}
        let url = Constants.shared.endPoint + Constants.shared.newsEndPoint + Constants.shared.besiktasUrl + Constants.shared.pageUrl + String(pageNumber) + Constants.shared.apiKeyUrl + Constants.shared.apiKey
        NetworkHandler.sendRequest(url: url) { (data, error) in
            guard let data = data?.data else {
                completion(nil, nil)
                return
            }
            do {
                let object = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(object,nil)
                
            }catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func fetchSearchData(query:String?,completion: @escaping (_ data : NewsResponse?, _ error: Error?)-> Void){
        guard let queryString = query else {return}
        let url = Constants.shared.endPoint + Constants.shared.newsEndPoint + queryString + Constants.shared.apiKeyUrl + Constants.shared.apiKey
        NetworkHandler.sendRequest(url: url) { (data, error) in
            guard let data = data?.data else {
                completion(nil, nil)
                return
            }
            do {
                let object = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(object,nil)
                
            }catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
}
