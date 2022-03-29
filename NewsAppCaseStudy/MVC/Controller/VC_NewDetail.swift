//
//  NewDetailViewController.swift
//  NewsAppCaseStudy
//
//  Created by Furkan Yıldız on 28.03.2022.
//

import UIKit

class VC_NewDetail: UIViewController {
    
    @IBOutlet var iv_NewsImage: UIImageView!
    @IBOutlet var txt_Title: UITextView!
    @IBOutlet var lbl_Source: UILabel!
    @IBOutlet var lbl_Date: UILabel!
    @IBOutlet var txt_Description: UITextView!
    
    var isFav = true
    var getModel : Article?
    var getFavData : New?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewData()
    }
    
    func viewData(){
        
        if getModel != nil {
            txt_Title.text = getModel?.title
            txt_Description.text = getModel?.articleDescription
            lbl_Source.text = getModel?.source.name
            SetImageHandler.setImage(path: getModel!.urlToImage, imageView: iv_NewsImage)
            updateDateLabel(date: getModel!.publishedAt)
        } else if getFavData != nil {
            
            txt_Title.text = getFavData!.title
            txt_Description.text = getFavData!.newsDescription
            lbl_Source.text = getFavData!.author
            SetImageHandler.setImage(path: getFavData!.newsImage!, imageView: iv_NewsImage)
            updateDateLabel(date: getFavData!.newsDate!)
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
    
    
    @IBAction func btn_Fav(_ sender: Any) {
        
        if isFav {
            DAL.saveData(title: getModel?.title ?? "", author: getModel?.author ?? "", newsdate: getModel!.publishedAt, explain: getModel!.articleDescription, newsimage: getModel!.urlToImage, setfavorite: true, weburl: getModel!.url)
            isFav = false
        }
        
    }
    

}
