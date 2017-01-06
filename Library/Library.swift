//
//  Library.swift
//  Library
//
//  Created by Amy Roberson on 1/5/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import Foundation


class LibrarySystem {
    var books: [Book]
    
    init(books: [Book]){
        self.books = books
    }
    
    init?(json: Data){
        do{
            guard let jsonObject = try JSONSerialization.jsonObject(with: json, options: []) as? [String:Any] else {
                return nil }
            self.books = []
            if let dictionaryArray = jsonObject["books"] as? [[String: Any]] {
                for dictionary in dictionaryArray {
                    if let book = Book(dictionary: dictionary) {
                        self.books.append(book)
                    }
                }
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    func toDictionary() -> [String:Any]{
        let array = (self.books.map{$0.toDictionary()})
        let dictionary: [String: Any] = [
            "books": array
        ]
        return dictionary
    }
    
    internal func toJSON() throws -> Data {
    let jsonRepresentation = try JSONSerialization.data(withJSONObject: self.toDictionary(), options: [])
    return jsonRepresentation
    }
    
    
}
