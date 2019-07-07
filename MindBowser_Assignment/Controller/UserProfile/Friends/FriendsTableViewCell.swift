//
//  FriendsTableViewCell.swift
//  MindBowser_Assignment
//
//  Created by Harshal on 07/07/19.
//  Copyright © 2019 Harshal. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgTimeLine: UIImageView!
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblScreenName: UILabel!
    @IBOutlet weak var lblDescr: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgThumbnail.makeBorder(withCornerRadius: imgThumbnail.frame.height*0.5)
        viewContainer.makeBorder(withCornerRadius: 15.0)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0,width: UIScreen.main.bounds.width, height: 120.0)
        gradientLayer.colors = [UIColor(red:55.0/255, green:149.0/255, blue:227.0/255, alpha:0.3).cgColor,UIColor(red:20.0/255, green:77.0/255, blue:120.0/255, alpha:1.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.7)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        imgTimeLine.layer.insertSublayer(gradientLayer, at: 0)

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
