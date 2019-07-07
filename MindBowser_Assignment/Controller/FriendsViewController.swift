//
//  FriendsViewController.swift
//  MindBowser_Assignment
//
//  Created by Harshal on 07/07/19.
//  Copyright © 2019 Harshal. All rights reserved.
//

import UIKit
import TwitterKit

class FriendsViewController: UIViewController {
    
    @IBOutlet weak var tableFriends: UITableView!
    var friends = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFriendList()
    }
    
    func getFriendList() {
        let id = UserDefaults.standard.value(forKey: "userid") as! String
        let urlString =  "https://api.twitter.com/1.1/friends/list.json?userid\(id)"
        var clientError : NSError?
        let client = TWTRAPIClient()
        let req = client.urlRequest(withMethod: "GET", urlString: urlString, parameters: nil, error: &clientError)
        client.sendTwitterRequest(req) { (response, data, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                    print(json)
//                    self.friends = json
                    DispatchQueue.main.async {
                        self.refreshView()
                    }
                } catch let jsonError {
                    print(jsonError)
                }
            }
        }
    }
    func refreshView() {
        DispatchQueue.main.async {
            self.tableFriends.reloadData()
        }
    }
}
extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableViewCell", for: indexPath) as! FriendsTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    
}

