//
//  ViewController.swift
//  Twitter_Login-Demo
//
//  Created by Harshal on 25/06/19.
//  Copyright © 2019 Harshal. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnTwitterLoginTapped(_ sender: UIButton) {
        TWTRTwitter.sharedInstance().logIn { (session, error) in
            if let err = error {
                self.showMessage("Login Failed", err.localizedDescription)
            } else {
                self.getAccessToken()
            }
        }
    }
    
    func getAccessToken() {
        ApiManager.shared.getAccessToken(with: { (statusCode, data) in
            if let data = data {
                do
                {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
                    print(json)
                    
                } catch {
                    self.showMessage("Access Token JSON error::-", error.localizedDescription)
                }
            }
        }) { (errorString) in
            print(errorString!)
        }
    }
    
}

