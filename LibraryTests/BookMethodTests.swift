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
    
    func testFailableINIT1(){
        let person: User? = nil
        let dictionary: [String: Any] = [
            "checkedOut" : true,
            "title" : "Design Patterns",
            "author" : "Helm",
            "genre" : "Non-Fiction",
            "user" : person as Any
        ]
        
        let book1 = Book(dictionary: dictionary)
        XCTAssertEqual(book1?.checkedOut, true)
        XCTAssertEqual(book1?.title, "Design Patterns")
        XCTAssertEqual(book1?.author, "Helm")
        XCTAssertEqual(book1?.genre, "Non-Fiction")
        XCTAssertNil(book1?.user)
    }
    
    func testToDictionary(){
        let user1 = User(userName: "Kupri", firstName: "Amy", lastName: "Roberson", id: 0001)
        let book1 = Book(checkedOut: true, title: "Design Patterns", author: "Helm", genre: "Non-Fiction", user: user1)
        let newDictionary = book1.toDictionary()
        if let checkedOut: Bool = (newDictionary["checkedOut"] as? Bool),
            let title: String = (newDictionary["title"] as? String),
            let author: String = (newDictionary["author"] as? String),
            let genre: String = (newDictionary["genre"] as? String),
            let user: [String: Any] = (newDictionary["user"] as? [String: Any]) {
           
            let newUser = User(dictionary: user)
            XCTAssertEqual(checkedOut, true)
            XCTAssertEqual(title, "Design Patterns")
            XCTAssertEqual(newUser?.id, 0001)
            XCTAssertEqual(newUser?.userName, "Kupri")
            XCTAssertEqual(newUser?.firstName, "Amy")
            XCTAssertEqual(newUser?.lastName, "Roberson")
            XCTAssertEqual(author, "Helm")
            XCTAssertEqual(genre, "Non-Fiction")
        } else {
            XCTAssert(false)
        }
    }
    
    func testToDictionary1(){
        let book1 = Book(checkedOut: true, title: "Design Patterns", author: "Helm", genre: "Non-Fiction", user: nil)
        let newDictionary = book1.toDictionary()
        if let checkedOut = newDictionary["checkedOut"] as? Bool,
            let title = newDictionary["title"] as? String,
            let author = newDictionary["author"] as? String,
            let genre = newDictionary["genre"] as? String {
            XCTAssertEqual(checkedOut, true)
            XCTAssertEqual(title, "Design Patterns")
            XCTAssertEqual(author, "Helm")
            XCTAssertEqual(genre, "Non-Fiction")
        } else {
            XCTAssert(false)
        }
    }
    
    func testArray(){
        let dictionary: [[String: Any]] = [
            [
                "checkedOut": false,
                "title": "iOS for Dummies",
                "author": "TJ (who else?)",
                "genre": "Technical"
            ],
            [
                "checkedOut": false,
                "title": "Harry Potter and the something",
                "author": "JK Rowling",
                "genre": "Fantasy"
            ],
            [
                "checkedOut": false,
                "title": "String Theory",
                "author": "Foster Wallace",
                "genre": "Biography"
            ],
            [
                "checkedOut": true,
                "title": "100 years of solitude",
                "author": "Gabriel Garcia Marquez",
                "genre": "Fiction",
                "user": [
                    "userName": "dev@tiy.com",
                    "firstName": "Master",
                    "lastName": "Developer",
                    "id": 7000
                ]
            ]
        ]
        let books = Book.array(from: dictionary)
        XCTAssertEqual(books?[0].title, "iOS for Dummies")
        XCTAssertEqual(books?[0].checkedOut, false)
        XCTAssertEqual(books?[1].title, "Harry Potter and the something")
        XCTAssertEqual(books?[1].checkedOut, false)
        XCTAssertEqual(books?[2].title, "String Theory")
        XCTAssertEqual(books?[3].checkedOut, true)
        XCTAssertEqual(books?[3].title,"100 years of solitude")
        XCTAssertEqual(books?[3].user?.firstName, "Master")
        XCTAssertEqual(books?[3].user?.id, 7000)
        XCTAssertNil(books?[1].user)
    }
    
}
