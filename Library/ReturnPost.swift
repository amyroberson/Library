//
//  ReturnOst.swift
//  Library
//
//  Created by Amy Roberson on 1/6/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import Foundation

enum ReturnPostResult {
    case success(Book)
    case failure(ReturnPost.Error)
}

struct ReturnPostURL {
    static let url = URL(string: "https://reece-tiy-library.herokuapp.com/checkin_book.json")!
}


class ReturnPost{
    enum Error: Swift.Error{
        case http(HTTPURLResponse)
        case system(Swift.Error)
        case API(APIURL.Error)
    }
    
    let session: URLSession = URLSession.shared
    
    var request: URLRequest
    
    init(){
        request = URLRequest(url: ReturnPostURL.url)
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    }
    
    //need to return objects / or error like he did in examples
    internal func pushGlobalPost(json: Data, completion: @escaping (ReturnPostResult) -> ()) {
        request.httpBody = json
        let task = session.dataTask(with: request) {(optionalData, optionalResponse, optionalError) in
            if let data = optionalData {
                completion(self.processPostReturn(data: data))
            } else if let response = optionalResponse {
                let error = Error.http(response as! HTTPURLResponse)
                completion(.failure(error))
            } else {
                completion(.failure(.system(optionalError!)))
            }
        }
        task.resume()
    }
    
    internal func processPostReturn(data: Data) -> ReturnPostResult {
        if let dictionary = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]
        {
            if let book = Book(dictionary: dictionary){
                return .success(book)
            } else {
                return .failure(.API(.invalidJSONData))
            }
        } else {
            return .failure(.API(.invalidJSONData))
        }
    }
}
