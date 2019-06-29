//
//  Ext-UIViewController.swift
//  MindBowser_Assignment
//
//  Created by Harshal on 29/06/19.
//  Copyright © 2019 Harshal. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showMessage(_ title: String, _ message: String) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}
