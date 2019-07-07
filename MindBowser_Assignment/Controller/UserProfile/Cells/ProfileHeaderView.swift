//
//  ProfileHeaderView.swift
//  Macys
//
//  Created by Redbytes on 12/06/19.
//  Copyright © 2019 Macys. All rights reserved.
//

import UIKit

class ProfileHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var imgvwTimeLine: UIImageView!
    @IBOutlet weak var imgviewContainer: UIView!
    @IBOutlet weak var imgvwProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmailid: UILabel!
    @IBOutlet weak var btnFollowers: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnFollowing: UIButton!
    
    @IBOutlet weak var btnFriends: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnFriends.makeBorder(withCornerRadius: 10)
        btnFollowing.makeBorder(withCornerRadius: 10)
        btnFollowers.makeBorder(withCornerRadius: 10)
        
        btnFriends.layer.borderColor = btnFriends.titleColor(for: .normal)?.cgColor
        btnFollowers.layer.borderColor = btnFollowers.titleColor(for: .normal)?.cgColor
        btnFollowing.layer.borderColor = btnFollowing.titleColor(for: .normal)?.cgColor
        
        btnFriends.layer.borderWidth = 1.0
        btnFollowers.layer.borderWidth = 1.0
        btnFollowing.layer.borderWidth = 1.0
    }
    
}
