//
//  NewsResponse.swift
//  NewsAppCaseStudy
//
//  Created by Furkan Yıldız on 28.03.2022.
//

import Foundation

struct NewsResponse: Codable {
    let status:  String
    let totalResults: Int
    let articles: [Article]
}
