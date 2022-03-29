//
//  Constants.swift
//  NewsAppCaseStudy
//
//  Created by Furkan Yıldız on 28.03.2022.
// https://newsapi.org/v2/everything?q=besiktas&amp;page=1&amp;apiKey=90f78b5e459f4557a6d285161db89
// https://newsapi.org/v2/everything?q=bitcoin&apiKey=7c536964978440e98dddb93c96afcd9a
//dev.furkanios -> Apı key = 7c536964978440e98dddb93c96afcd9a
//calizay -> Api key = df0e8002b278488e991172e680a5a094

import Foundation

class Constants {
    
    static var shared = Constants()
    
    let endPoint: String = "https://newsapi.org/v2"
    let apiKey: String = "df0e8002b278488e991172e680a5a094"
    let newsEndPoint = "/everything?q="
    let besiktasUrl = "besiktas"
    let pageUrl = "&page="
    let apiKeyUrl = "&apiKey="
    let segueListToDetail = "toDetailVCNews"
    let segueFavToDetail = "toDetailVCFavs"
    
}
