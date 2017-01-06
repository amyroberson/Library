//
//  Book.swift
//  Library
//
//  Created by Amy Roberson on 1/5/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import Foundation

public struct Book {
    var checkedOut: Bool
    let title: String
    let author: String
    let genre: String
    var checkedOutBy: String?
    let id: Int
    
    
    public init(checkedOut: Bool, title: String, author: String, genre: String, id: Int, checkedOutBy: String?){
        self.checkedOut = checkedOut
        self.title = title
        self.author = author
        self.genre = genre
        self.id = id
        self.checkedOutBy = checkedOutBy
    }

    internal init?(dictionary: [String: Any] ){
        guard let checkedOut = dictionary["checkedOut"] as? Bool,
            let title = dictionary["title"] as? String,
            let author = dictionary["author"] as? String,
            let genre = dictionary["genre"] as? String,
            let id = dictionary["id"] as? Int else {
                return nil
        }
        guard let checkedOutBy = dictionary["checkedOutBy"] as? String else {
            self.init(checkedOut: checkedOut, title: title, author: author, genre: genre, id: id, checkedOutBy: nil)
            return
        }
        self.init(checkedOut: checkedOut, title: title, author: author, genre: genre, id: id, checkedOutBy: checkedOutBy)
    }
    
    func toDictionary() -> [String: Any]{
        let dictionary: [String: Any?] = [
            "checkedOut" : self.checkedOut,
            "title" : self.title,
            "author" : self.author,
            "genre" : self.genre,
            "id" : self.id,
            "checkedOutBy" : self.checkedOutBy
        ]
        return dictionary
        
    }
    
    mutating func checkOut(name: String){
        self.checkedOut = true
        if self.checkedOutBy == nil {
            self.checkedOutBy = name
        } //else error should happen here
    }
    
    mutating func returnBook(){
        if self.checkedOut{
            self.checkedOut = false
            self.checkedOutBy = nil
            // in future check logic here to make sure the returner is == checkedOutBy
        }
    }
    
    internal static func array(from jsonObjects: [[String: Any]]) -> [Book]? {
        let bookArray = jsonObjects.flatMap(Book.init(dictionary:))
        
        if jsonObjects.count != bookArray.count {
            return nil
        }
        
        return bookArray
    }
    
}
