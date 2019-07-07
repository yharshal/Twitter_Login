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
    var name = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnTwitterLoginTapped(_ sender: UIButton) {
        TWTRTwitter.sharedInstance().logIn { (session, error) in
            if error != nil {
                if let err = error {
                    print(err.localizedDescription)
                }
            } else {
                if let loginSession = session{
                    UserDefaults.standard.set(loginSession.authToken, forKey: "AuthToken")
                    UserDefaults.standard.synchronize()
                    self.getEmailid(loginSession)
                }
            }
        }
    }
    
    fileprivate func getEmailid(_ loginSession: TWTRSession)  {
        let client = TWTRAPIClient.withCurrentUser()
        client.requestEmail { email, error in
            if (error != nil) {
                print(error!.localizedDescription)
            } else {
                UserDefaults.standard.set(loginSession.userID, forKey: "userid")
                UserDefaults.standard.set(loginSession.userName, forKey: "userName")
                self.name = loginSession.userName
                UserDefaults.standard.set(email!, forKey: "email")
                UserDefaults.standard.synchronize()
                self.getUserDetails(withId: loginSession.userID)
            }
        }
    }
    
    fileprivate func getUserDetails(withId id: String) {
        let client = TWTRAPIClient(userID: id)
        client.loadUser(withID: id, completion: { (user, error) in
            if error != nil {
                if let err = error {
                    print(err.localizedDescription)
                }
            } else {
                if let userData = user {
                    UserDefaults.standard.set(userData.profileImageLargeURL, forKey: "profilePic")
                    UserDefaults.standard.synchronize()
                    self.navigateToProfile()
                }
            }
        })
    }
    
    fileprivate func navigateToProfile() {
        let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileVC.navigationItem.title = self.name
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
}

