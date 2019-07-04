//
//  TwitterClient.swift
//  MindBowser_Assignment
//
//  Created by Harshal on 04/07/19.
//  Copyright © 2019 Harshal. All rights reserved.
//

import UIKit

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    static var shared: TwitterClient {
        let client = TwitterClient(baseURL: URL(string: ApiConstants.baseURL), consumerKey: StringConstants.kConsumerKey, consumerSecret: StringConstants.kConsumerSecret)
        return client!
    }
    
    
    
}
