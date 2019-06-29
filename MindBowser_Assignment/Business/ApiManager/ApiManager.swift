//
//  ApiManager.swift
//  MindBowser_Assignment
//
//  Created by Harshal on 29/06/19.
//  Copyright © 2019 Harshal. All rights reserved.
//

import Foundation

class ApiManager {
    
    static let shared = ApiManager()
    
    var configuration: URLSessionConfiguration {
       let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        config.timeoutIntervalForResource = 20
        config.requestCachePolicy = .useProtocolCachePolicy
        return config
    }
    
    private func getBasicAuthString() -> String {
        let loginString = "\(StringConstants.kConsumerKey):\(StringConstants.kConsumerSecret)"
        let loginData = loginString.data(using: .utf8)
        return (loginData?.base64EncodedString())!
    }    
    
    func getAccessToken(with successHandler: @escaping ((_ statusCode:Int?, _ data: Data?) -> ()), errorHandler: @escaping (_ error: String?) -> ()) {
        
        let url = URL(string: ApiConstants.getAccessToken + "?grant_type=client_credentials")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("Basic \(getBasicAuthString())", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let postData = NSMutableData(data: "grand_type=client_credentials".data(using: String.Encoding.utf8)!)
        request.httpBody = postData as Data
        
        let session = URLSession(configuration: configuration)
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                errorHandler(error!.localizedDescription)
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        if let data = data {
                            successHandler(httpResponse.statusCode, data)
                        } else {
                            successHandler(httpResponse.statusCode, nil)
                        }
                    } else {
                        successHandler(httpResponse.statusCode, nil)
                    }
                }
            }
        }.resume()
    }
    
    
    
}


