//
//  Ext-UIView.swift
//  MindBowser_Assignment
//
//  Created by Harshal on 07/07/19.
//  Copyright © 2019 Harshal. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    func makeBorder(withCornerRadius radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
}
