//
//  LibraryTests.swift
//  LibraryTests
//
//  Created by Amy Roberson on 1/5/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import XCTest
@testable import Library

class LibraryTests: XCTestCase {
    
    func testToDictionary(){
        let user1 = User(userName: "Kupri", firstName: "Amy", lastName: "Roberson", id: 0001)
        let book1 = Book(checkedOut: true, title: "Design Patterns", author: "Helm", genre: "Non-Fiction", user: user1)
        let library = LibrarySystem(books: [book1])
        let dictionary = library.toDictionary()
        if let books = (dictionary["books"]) as? [[String: Any]] {
            var bookArray = books.flatMap(Book.init(dictionary: ))
            XCTAssertEqual(books.count, 1)
            XCTAssertEqual(bookArray[0].title, "Design Patterns")
        }
    }
    
    func testToFromJSON(){
        let user1 = User(userName: "Kupri", firstName: "Amy", lastName: "Roberson", id: 0001)
        let book1 = Book(checkedOut: true, title: "Design Patterns", author: "Helm", genre: "Non-Fiction", user: user1)
        let firstLibrary = LibrarySystem(books: [book1])
        do {
            let data = try firstLibrary.toJSON()
            let newLibrary = LibrarySystem(json: data)
            XCTAssertEqual(newLibrary?.books[0].title, firstLibrary.books[0].title)
        } catch {
            XCTAssert(false)
        }
    }
    
    
}
