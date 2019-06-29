//
//  Ext-UIImageView.swift
//  MindBowser_Assignment
//
//  Created by Harshal on 29/06/19.
//  Copyright © 2019 Harshal. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
