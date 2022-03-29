//
//  TVC_NewsList.swift
//  NewsAppCaseStudy
//
//  Created by Furkan Yıldız on 28.03.2022.
//

import UIKit

class TVC_NewsList: UITableViewCell {
    
    @IBOutlet var lbl_Title: UILabel!
    @IBOutlet var lbl_Description: UILabel!
    @IBOutlet var lbl_Source: UILabel!
    @IBOutlet var lbl_Date: UILabel!
    @IBOutlet var iv_Image: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(data: Article) {
        if data.title != ""{
            lbl_Title.text = data.title
            lbl_Description.text = data.articleDescription
            lbl_Source.text = data.source.name
            SetImageHandler.setImage(path: data.urlToImage, imageView: iv_Image)
            updateDateLabel(date: data.publishedAt)

        }
    }
    
    func bindDataFav(data: New) {
        if data.title != ""{
            lbl_Title.text = data.title
            lbl_Description.text = data.newsDescription
            lbl_Source.text = data.author
            SetImageHandler.setImage(path: data.newsImage!, imageView: iv_Image)
            updateDateLabel(date: data.newsDate!)

        }
    }

    
    private func updateDateLabel(date: String){
        let dateComponentsAll = date.split(separator: "T")
        let dateComponents = dateComponentsAll[0].split(separator: "-")
        let year = dateComponents.first ?? ""
        let month = dateComponents[1]
        let day = dateComponents.last ?? ""
        lbl_Date.text = "\(day).\(month).\(year)"
    }
    
}
