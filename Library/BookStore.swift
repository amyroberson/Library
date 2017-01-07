//
//  BookStore.swift
//  Library
//
//  Created by Amy Roberson on 1/5/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import Foundation

enum BookResult {
    case success([Book])
    case failure(BookStore.Error)
    
}

internal final class BookStore {
    enum Error: Swift.Error{
        case http(HTTPURLResponse)
        case system(Swift.Error)
        case API(APIURL.Error)
    }
    
    fileprivate let session: URLSession = {
        return URLSession(configuration: .default)
    }()
    
    internal func fetchGlobalBooks(completion: @escaping (BookResult) -> ()) {
        let task = session.dataTask(with: APIURL.globalStreamURL) {
            (optionalData, optionalResponse, optionalError) in
            
            if let data = optionalData {
                completion(self.processRecentBookRequest(data: data, error: optionalError))
            } else if let response = optionalResponse {
                let error = Error.http(response as! HTTPURLResponse)
                completion(.failure(error))
            } else {
                completion(.failure(.system(optionalError!)))
            }
            
        }
        task.resume()
    }
    
    internal func processRecentBookRequest(data: Data, error: Swift.Error?) -> BookResult {
        
        if let dictionary = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String: Any]] {
            if let books = Book.array(from: dictionary) {
                return .success(books)
            } else {
                return .failure(.API(.invalidJSONData))
            }
        } else {
            return .failure(.system(error!))
        }
    }
}
