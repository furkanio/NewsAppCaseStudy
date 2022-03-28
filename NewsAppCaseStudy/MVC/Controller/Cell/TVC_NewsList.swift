//
//  TVC_NewsList.swift
//  NewsAppCaseStudy
//
//  Created by Furkan Yıldız on 28.03.2022.
//

import UIKit

class TVC_NewsList: UITableViewCell {
    
    @IBOutlet var lbl_Title: UILabel!
    @IBOutlet var txtView_Description: UITextView!
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
    
}
