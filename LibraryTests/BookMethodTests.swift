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
        let book1 = Book(checkedOut: true, title: "Design Patterns", author: "Helm", genre: "Non-Fiction", id: 1, checkedOutBy: "Bob")
        XCTAssertEqual(book1.checkedOut, true)
        XCTAssertEqual(book1.title, "Design Patterns")
        XCTAssertEqual(book1.author, "Helm")
        XCTAssertEqual(book1.genre, "Non-Fiction")
    }
    
    func testFailableINIT(){
        let dictionary: [String: Any] = [
            "checkedOut" : true,
            "title" : "Design Patterns",
            "author" : "Helm",
            "genre" : "Non-Fiction",
            "id" : 5,
        ]
        
        let book1 = Book(dictionary: dictionary)
        XCTAssertEqual(book1?.checkedOut, true)
        XCTAssertEqual(book1?.title, "Design Patterns")
        XCTAssertEqual(book1?.author, "Helm")
        XCTAssertEqual(book1?.genre, "Non-Fiction")
    }
    
    func testFailableINIT1(){
        let dictionary: [String: Any] = [
            "checkedOut" : true,
            "title" : "Design Patterns",
            "author" : "Helm",
            "genre" : "Non-Fiction",
            "id" : 2,
            "checkedOutBy" : "Bob"
        ]
        
        let book1 = Book(dictionary: dictionary)
        XCTAssertEqual(book1?.checkedOut, true)
        XCTAssertEqual(book1?.title, "Design Patterns")
        XCTAssertEqual(book1?.author, "Helm")
        XCTAssertEqual(book1?.genre, "Non-Fiction")
        XCTAssertEqual(book1?.id, 2)
        XCTAssertEqual((book1?.checkedOutBy)!, "Bob")
    }
    
    func testToDictionary(){
        let book1 = Book(checkedOut: true, title: "Design Patterns", author: "Helm", genre: "Non-Fiction", id: 1, checkedOutBy: "Bobby")
        let newDictionary = book1.toDictionary()
        if let checkedOut: Bool = (newDictionary["checkedOut"] as? Bool),
            let title: String = (newDictionary["title"] as? String),
            let author: String = (newDictionary["author"] as? String),
            let genre: String = (newDictionary["genre"] as? String),
            let id:Int = (newDictionary["id"] as? Int){
           
            XCTAssertEqual(checkedOut, true)
            XCTAssertEqual(title, "Design Patterns")
            XCTAssertEqual(author, "Helm")
            XCTAssertEqual(genre, "Non-Fiction")
            XCTAssertEqual(id, 1)
            XCTAssertEqual(((newDictionary["checkedOutBy"] as! String)), "Bobby")
        } else {
            XCTAssert(false)
        }
    }
    
    func testToDictionary1(){
        let noOne: String? = nil
        let book1 = Book(checkedOut: true, title: "Design Patterns", author: "Helm", genre: "Non-Fiction", id: 45, checkedOutBy: noOne)
        let newDictionary = book1.toDictionary()
        if let checkedOut = newDictionary["checkedOut"] as? Bool,
            let title = newDictionary["title"] as? String,
            let author = newDictionary["author"] as? String,
            let genre = newDictionary["genre"] as? String,
            let id = newDictionary["id"] as? Int{
            XCTAssertEqual(checkedOut, true)
            XCTAssertEqual(title, "Design Patterns")
            XCTAssertEqual(author, "Helm")
            XCTAssertEqual(genre, "Non-Fiction")
            XCTAssertEqual(nil, newDictionary["checkedOutBy"] as? String)
            XCTAssertEqual(id, 45)
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
                "genre": "Technical",
                "id" : 1,
                "checkedOutBy": "Bob"
            ],
            [
                "checkedOut": false,
                "title": "Harry Potter and the something",
                "author": "JK Rowling",
                "genre": "Fantasy",
                "id" : 2,
            ],
            [
                "checkedOut": false,
                "title": "String Theory",
                "author": "Foster Wallace",
                "genre": "Biography",
                "id" : 3,
                "checkedOutBy" : "Joe"
            ],
            [
                "checkedOut": true,
                "title": "100 years of solitude",
                "author": "Gabriel Garcia Marquez",
                "genre": "Fiction",
                "id" : 4,
                "checkedOutBy" : "Amy"
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
    }
    
    func testReturn(){
         var book1 = Book(checkedOut: true, title: "Design Patterns", author: "Helm", genre: "Non-Fiction", id: 45, checkedOutBy: "Bob")
        book1.returnBook()
        XCTAssertEqual(book1.checkedOut, false)
    }
    
    func testCheckout(){
        var book1 = Book(checkedOut: false, title: "Design Patterns", author: "Helm", genre: "Non-Fiction", id: 45, checkedOutBy: nil)
        book1.checkOut(name: "Johnny")
        XCTAssertEqual(book1.checkedOut, true)
        XCTAssertEqual(book1.checkedOutBy, "Johnny")
    }
    
}
