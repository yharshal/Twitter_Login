//
//  ProfileViewController.swift
//  Macys
//
//  Created by Redbytes on 11/06/19.
//  Copyright © 2019 Macys. All rights reserved.
//

import UIKit
import TwitterKit


struct UserDetails {
    
    var userName: String!
    var profileURL: String!
    var timelineURL: String!
    var emailID: String!
    
}

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var collectionVIew: UICollectionView!
    
    var userID: String?
    var session: TWTRSession!
    var userDetails: UserDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionVIew.collectionViewLayout = StreachyProfileHeaderLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getUserInfo()
    }
    
    fileprivate func getUserInfo() {
        self.userDetails = UserDetails()
        
        let client = TWTRAPIClient.withCurrentUser()
        client.requestEmail { email, error in
            if (email != nil) {
                let recivedEmailID = email ?? ""
                self.userDetails?.emailID = recivedEmailID
                print(recivedEmailID)
            } else {
                print("error--: \(String(describing: error?.localizedDescription))");
            }
        }
        //To get profile image url and screen name
        let twitterClient = TWTRAPIClient(userID: session.userID)
        twitterClient.loadUser(withID: session.userID) {(user, error) in
            if let user = user {
                self.userDetails?.profileURL = user.profileURL.absoluteString
                self.userDetails?.userName = user.screenName
                self.userDetails?.timelineURL = user.profileImageLargeURL
            }
            self.refreshView()
        }
        let _ = client.requestEmail { email, error in
            if (email != nil) {
                let recivedEmailID = email ?? ""
                self.userDetails?.emailID = recivedEmailID
                self.refreshView()
            }else {
                print("error--: \(String(describing: error?.localizedDescription))");
            }
        }
    }
    
    
    func refreshView() {
        DispatchQueue.main.async {
            self.collectionVIew.reloadData()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    @IBAction func btnSettingsTapped(_ sender: Any) {
        
    }
    
    @IBAction func btnEditTapped(_ sender: Any) {
    }
    
    @IBAction func btnFollowTapped(_ sender: Any) {
        
    }
    
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UserDetailsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserDetailsCollectionViewCell", for: indexPath) as! UserDetailsCollectionViewCell
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProfileHeaderView", for: indexPath) as! ProfileHeaderView
        header.imgviewContainer.layer.cornerRadius = header.imgviewContainer.frame.height / 2
        header.imgviewContainer.clipsToBounds = true
        header.imgvwProfile.layer.cornerRadius = header.imgvwProfile.frame.height / 2
        header.imgvwProfile.clipsToBounds = true
        if userDetails != nil {
            
            if let url =  self.userDetails!.timelineURL{
                header.imgvwTimeLine.load(url: URL(string :url)!)
            }
            if let url =  self.userDetails!.profileURL{
                header.imgvwProfile.load(url: URL(string :url)!)
            }
            if let name = self.userDetails?.userName{
                header.lblName.text = name
            }
            if let email = self.userDetails?.emailID{
                header.lblStoreName.text = email
            }
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: UIScreen.main.bounds.height * 0.45)
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 2.5, height: collectionView.frame.width / 2 - 2.5)
    }
}


