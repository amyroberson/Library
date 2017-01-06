//
//  BookMethodTests.swift
//  Library
//
//  Created by Amy Roberson on 1/5/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import XCTest
@testable import Library

class BookMethodTests: XCTestCase {
    
    func testINIT(){
         let user1 = User(userName: "Kupri", firstName: "Amy", lastName: "Roberson", id: 0001)
        let book1 = Book(checkedOut: true, title: "Design Patterns", author: "Helm", genre: "Non-Fiction", user: user1)
        XCTAssertEqual(book1.checkedOut, true)
        XCTAssertEqual(book1.title, "Design Patterns")
        XCTAssertEqual(book1.author, "Helm")
        XCTAssertEqual(book1.genre, "Non-Fiction")
        XCTAssertEqual(book1.user?.firstName, "Amy")
    }
    
    func testFailableINIT(){
            let user1 = User(userName: "Kupri", firstName: "Amy", lastName: "Roberson", id: 0001)
        let dictionary: [String: Any] = [
            "checkedOut" : true,
            "title" : "Design Patterns",
            "author" : "Helm",
            "genre" : "Non-Fiction",
            "user" : user1.toDictionary()
        ]
        
        let book1 = Book(dictionary: dictionary)
        XCTAssertEqual(book1?.checkedOut, true)
        XCTAssertEqual(book1?.title, "Design Patterns")
        XCTAssertEqual(book1?.author, "Helm")
        XCTAssertEqual(book1?.genre, "Non-Fiction")
        XCTAssertEqual(book1?.user?.firstName, "Amy")
    }
    
    func testToDictionary(){
        let user1 = User(userName: "Kupri", firstName: "Amy", lastName: "Roberson", id: 0001)
        let book1 = Book(checkedOut: true, title: "Design Patterns", author: "Helm", genre: "Non-Fiction", user: user1)
        let newDictionary = book1.toDictionary()
        if let checkedOut = newDictionary["CheckedOut"] as? Bool,
            let title = newDictionary["title"] as? String,
            let author = newDictionary["author"] as? String,
            let genre = newDictionary["genre"] as? String,
            let user = newDictionary["user"] as? [String: Any] {
           
            let newUser = User(dictionary: user)
            XCTAssertEqual(checkedOut, true)
            XCTAssertEqual(title, "Design Patterns")
            XCTAssertEqual(newUser?.id, 0001)
            XCTAssertEqual(newUser?.userName, "Kupri")
            XCTAssertEqual(newUser?.firstName, "Amy")
            XCTAssertEqual(newUser?.lastName, "Roberson")
            XCTAssertEqual(author, "Helm")
            XCTAssertEqual(genre, "Non-Fiction")
        }
    }
    
    
}
