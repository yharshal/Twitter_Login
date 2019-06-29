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
            if statusCode == 200 {
                if let data = data {
                    do
                    {
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
                        print("-----Access Token JSON::- -------\n",json)
                        if let accessTokenType = json["token_type"] as? String, let accessToken = json["access_token"] as? String {
                            UserDefaults.standard.set("\(accessTokenType) \(accessToken)", forKey: StringConstants.kAccessTokenKey)
                            UserDefaults.standard.synchronize()
                            let profile = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                            self.navigationController?.pushViewController(profile, animated: true)
                        }
                    } catch {
                        self.showMessage("Login Failed", error.localizedDescription)
                    }
                }
            } else {
                self.showMessage("Login Failed", "Failed with status code::- \(statusCode!)")
            }
        }) { (errorString) in
            print(errorString!)
            self.showMessage("Login Failed", "Failed with status error::- \(errorString!)")
        }
    }
    
}

