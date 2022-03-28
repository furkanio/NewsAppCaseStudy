//
//  NetworkHandler.swift
//  NewsAppCaseStudy
//
//  Created by Furkan Yıldız on 28.03.2022.
//

import Foundation
import Alamofire

class NetworkHandler{
    class func sendRequest(url: String, completion: @escaping (_ data : AFDataResponse<Data>?, _ error: Error?) -> Void){
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString)).validate(contentType: ["application/json"])
        .responseData(completionHandler: { (response) in
            guard response.data != nil else {
                completion(nil, nil)
                return
            }
            completion(response, nil)
            })
    }
    
}
