//
//  NewDetailViewController.swift
//  NewsAppCaseStudy
//
//  Created by Furkan Yıldız on 28.03.2022.
//

import UIKit
import WebKit

class VC_NewDetail: UIViewController {
    
    @IBOutlet var iv_NewsImage: UIImageView!
    @IBOutlet var txt_Title: UITextView!
    @IBOutlet var lbl_Source: UILabel!
    @IBOutlet var lbl_Date: UILabel!
    @IBOutlet var txt_Description: UITextView!
    @IBOutlet var barItemFav: UIBarButtonItem!
    
    var isFav : Bool?
    var getModel : Article?
    var getFavData : New?
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()

    }
    
    func prepareView(){
        if getModel != nil {
            txt_Title.text = getModel?.title
            txt_Description.text = getModel?.articleDescription
            lbl_Source.text = getModel?.source.name
            SetImageHandler.setImage(path: getModel!.urlToImage, imageView: iv_NewsImage)
            updateDateLabel(date: getModel!.publishedAt)
            isFav = false
        } else if getFavData != nil {
            
            txt_Title.text = getFavData!.title
            txt_Description.text = getFavData!.newsDescription
            lbl_Source.text = getFavData!.author
            SetImageHandler.setImage(path: getFavData!.newsImage!, imageView: iv_NewsImage)
            updateDateLabel(date: getFavData!.newsDate!)
            isFav = getFavData?.setFavoriteBool
            barItemFav.isSelected = isFav!
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
        
        if isFav == false {
            DAL.saveData(title: getModel?.title ?? "", author: getModel?.source.name ?? "", newsdate: getModel!.publishedAt, explain: getModel!.articleDescription, newsimage: getModel!.urlToImage, setfavorite: true, weburl: getModel!.url)
            isFav = true
            barItemFav.isSelected = isFav!
        }
        
    }
    
    
    
    @IBAction func btn_webView_Source_TUI(_ sender: Any) {
        let webView = VC_WebView()
        if getModel != nil {
            webView.webUrl = getModel!.url
            webView.delegate = self
            navigationController?.pushViewController(webView, animated: true)

        } else if getFavData != nil {
            webView.webUrl = getFavData!.webUrl ?? ""
            webView.delegate = self
            navigationController?.pushViewController(webView, animated: true)
        }
        
    }
    
    @IBAction func btn_Share(_ sender: Any) {
        
        var webUrl = ""
        
        if getModel != nil {
            webUrl = getModel!.url
        } else if getFavData != nil {
            webUrl = (getFavData?.webUrl)!
        }
        
        let item : [Any] = ["You should read this news :)", URL(string: webUrl)!]
        let activityViewController = UIActivityViewController(activityItems: item as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        

    }

}
