//
//  PostCreator.swift
//  Library
//
//  Created by Amy Roberson on 1/6/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import Foundation
struct CheckOutPostURL {
    static let url = URL(string: "https://reece-tiy-library.herokuapp.com/testPush.json")!
}


struct CheckOutPost {
    
    let session: URLSession = URLSession.shared
    
    var request: URLRequest
    
    init(){
        request = URLRequest(url: CheckOutPostURL.url)
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
    }
    //need to return objects / or error like he did in examples
    internal mutating func pushGlobalPost(json: Data){
        request.httpBody = json
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
