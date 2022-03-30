//
//  VC_WebView.swift
//  NewsAppCaseStudy
//
//  Created by Furkan Yıldız on 30.03.2022.
//

import UIKit
import WebKit

class VC_WebView: UIViewController, WKUIDelegate {
    
    weak var delegate: VC_NewDetail?
    var webUrl = "https://www.apple.com"
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if webUrl != "" {
            let myURL = URL(string:webUrl)
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        }
       
    }
    
    
}
