//
//  ProfileViewController.swift
//  Macys
//
//  Created by Redbytes on 11/06/19.
//  Copyright © 2019 Macys. All rights reserved.
//

import UIKit
import TwitterKit


class ProfileViewController: UIViewController {
    
    @IBOutlet weak var collectionVIew: UICollectionView!
    
    var userID: String?
    var userDetails = [String: Any]()
    var tweets = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionVIew.collectionViewLayout = StreachyProfileHeaderLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getUserInfo()
    }
    
    func getUserInfo() {
        let id = UserDefaults.standard.value(forKey: "userid") as! String
        let urlString =  "http://api.twitter.com/1.1/users/show.json?user_id=\(id)"
        var clientError : NSError?
        let client = TWTRAPIClient()
        let req = client.urlRequest(withMethod: "GET", urlString: urlString, parameters: nil, error: &clientError)
        client.sendTwitterRequest(req) { (response, data, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                    self.userDetails = json
                    DispatchQueue.main.async {
                        self.getTweets()
                    }
                } catch let jsonError {
                    print(jsonError)
                }
            }
        }
    }
    
    func getTweets() {
        let urlString = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=twitterapi&count=20"
        var clientError : NSError?
        let client = TWTRAPIClient()
        let req = client.urlRequest(withMethod: "GET", urlString: urlString, parameters: nil, error: &clientError)
        client.sendTwitterRequest(req) { (response, data, error) in
            if error != nil{
                print(error!.localizedDescription)
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String: Any]]
                    self.tweets = json
                    self.refreshView()
                } catch let jsonError {
                    print(jsonError)
                }
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
    
    @IBAction func btnFriendsTapped(_ sender: Any) {

    }
    
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UserDetailsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserDetailsCollectionViewCell", for: indexPath) as! UserDetailsCollectionViewCell
        let tweet = tweets[indexPath.row]
        if let user = tweet["user"] as? [String: Any]{
            if let name = user["name"] as? String{
                cell.lblName.text = name
            }
            if let descr = user["description"] as? String{
                cell.lblDesc.text = descr
            }
            if let url = user["profile_image_url_https"] as? String{
                cell.imgTweet.dowloadFromServer(link: url)
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProfileHeaderView", for: indexPath) as! ProfileHeaderView
        header.imgviewContainer.layer.cornerRadius = header.imgviewContainer.frame.height / 2
        header.imgviewContainer.clipsToBounds = true
        header.imgvwProfile.layer.cornerRadius = header.imgvwProfile.frame.height / 2
        header.imgvwProfile.clipsToBounds = true
        if let url =  UserDefaults.standard.value(forKey: "profilePic") as? String{
            header.imgvwProfile.dowloadFromServer(link: url, contentMode: .scaleAspectFit)
        }
        if let email = UserDefaults.standard.value(forKey: "email") as? String{
            header.lblEmailid.text = email
        }
        if let bannerImage = userDetails["profile_banner_url"] as?  String {
            header.imgvwTimeLine.dowloadFromServer(link: bannerImage, contentMode: .scaleAspectFill)
        }
        if let screenName = userDetails["screen_name"] as?  String, let name = userDetails["name"] as?  String {
            header.lblName.text = "\(name) | @\(screenName)"
        }
        if let followers = userDetails["followers_count"] as? Int {
            header.btnFollowers.setTitle("\(followers) Followers", for: .normal)
        } else {
            header.btnFollowers.setTitle("Followers", for: .normal)
        }
        if let following = userDetails["following"] as? Int {
            header.btnFollowing.setTitle("\(following) Following", for: .normal)
        } else {
            header.btnFollowing.setTitle("Following", for: .normal)
        }
        if let friends = userDetails["friends_count"] as? Int {
            header.btnFriends.setTitle("\(friends) Friends", for: .normal)
        } else {
            header.btnFriends.setTitle("Friends", for: .normal)
        }
        if let descr = userDetails["location"] as? String {
            header.lblDescription.text = descr
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


