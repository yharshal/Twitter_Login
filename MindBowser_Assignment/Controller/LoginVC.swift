//
//  ViewController.swift
//  Twitter_Login-Demo
//
//  Created by Harshal on 25/06/19.
//  Copyright © 2019 Harshal. All rights reserved.
//

import UIKit
import TwitterKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnTwitterLoginTapped(_ sender: UIButton) {
        TWTRTwitter.sharedInstance().logIn { (session, error) in
            if let err = error {
                let alert = UIAlertController.init(title: "Login Failed", message: err.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            } else {
                if let loginSession = session {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                    vc.session = loginSession
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}

