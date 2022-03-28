//
//  SetImageHandler.swift
//  NewsAppCaseStudy
//
//  Created by Furkan Yıldız on 28.03.2022.
//

import Foundation
import Kingfisher
import UIKit

class SetImageHandler {
    class func setImage(path: String, imageView: UIImageView){
        let completeUrl =  path
        guard let url = URL(string: completeUrl) else {return}
        imageView.kf.setImage(with: url)
    }
}
