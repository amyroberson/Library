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
    let user: User?
    
    public init(checkedOut: Bool, title: String, author: String, genre: String, user: User?){
        self.checkedOut = checkedOut
        self.title = title
        self.author = author
        self.genre = genre
        self.user = user
    }

    internal init?(dictionary: [String: Any] ){
        guard let checkedOut = dictionary["checkedOut"] as? Bool,
            let title = dictionary["title"] as? String,
            let author = dictionary["author"] as? String,
            let genre = dictionary["genre"] as? String   else {
                return nil
        }
        guard let person: [String:Any] = dictionary["user"] as? [String : Any] else {
             self.init(checkedOut: checkedOut, title: title, author: author, genre: genre, user: nil)
            return
        }
        let user = User(dictionary: person)
        self.init(checkedOut: checkedOut, title: title, author: author, genre: genre, user: user!)
    }
    
    func toDictionary() -> [String: Any]{
        let dictionary: [String: Any?] = [
            "checkedOut" : self.checkedOut,
            "title" : self.title,
            "author" : self.author,
            "genre" : self.genre,
            "user" : self.user?.toDictionary()
        ]
        return dictionary
        
    }
    
    mutating func checkOut(){
        //set due date
        // ischeckedOut = true
    }
    
    mutating func returnBook(){
        // set dueDate to nil
        // ischeckedout = false
    }
    
    internal static func array(from jsonObjects: [[String: Any]]) -> [Book]? {
        let bookArray = jsonObjects.flatMap(Book.init(dictionary:))
        
        if jsonObjects.count != bookArray.count {
            return nil
        }
        
        return bookArray
    }
    
}
