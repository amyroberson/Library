//
//  ReturnOst.swift
//  Library
//
//  Created by Amy Roberson on 1/6/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import Foundation

struct ReturnPostURL {
    static let url = URL(string: "https://reece-tiy-library.herokuapp.com/testPush.json")!
}


struct ReturnPostCreator {
    
    let session = URLSession.shared
    
    var request: URLRequest {
        var tempRequest = URLRequest(url: ReturnPostURL.url)
        tempRequest.httpMethod = "POST"
        tempRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        tempRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let payload = try! JSONSerialization.data(withJSONObject: ["id":1,
                                                                   "checkOutBy": "Amy"// update checkoutby name
            ]
            , options: [])
        tempRequest.httpBody = payload
        return tempRequest
    }
    
    
    internal func pushGlobalPost(){
        let task = session.dataTask(with: request) { (optionalData, optionalResponse, optionalError) in
            guard let data = optionalData,
                let objects = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]
                else {
                    print("optionalResponse: \(optionalResponse)") //needs to be handled, not necessarily thrown
                    print("optionalError: \(optionalError)") // needs to be handled
                    return
            }
            print(objects)
        }
        
        task.resume()
    }
}
