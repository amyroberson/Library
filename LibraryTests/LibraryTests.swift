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
        let book1 = Book(checkedOut: true, title: "Design Patterns", author: "Helm", genre: "Non-Fiction", id: 4, checkedOutBy: "Bob")
        let library = LibrarySystem(books: [book1])
        let dictionary = library.toDictionary()
        if let books = (dictionary["books"]) as? [[String: Any]] {
            var bookArray = books.flatMap(Book.init(dictionary: ))
            XCTAssertEqual(books.count, 1)
            XCTAssertEqual(bookArray[0].title, "Design Patterns")
        }
    }
    
    func testToDictionary1(){
        let book1 = Book(checkedOut: true, title: "Design Patterns", author: "Helm", genre: "Non-Fiction",  id: 3, checkedOutBy: "Amy")
        let book2 = Book(checkedOut: true, title: "Designing Dragons", author: "Jeff", genre: "Fiction",  id: 4, checkedOutBy: "Bobby")
        let library = LibrarySystem(books: [book1, book2])
        let dictionary = library.toDictionary()
        if let books = (dictionary["books"]) as? [[String: Any]] {
            var bookArray = books.flatMap(Book.init(dictionary: ))
            XCTAssertEqual(books.count, 2)
            XCTAssertEqual(bookArray[0].title, "Design Patterns")
            XCTAssertEqual(bookArray[1].title, "Designing Dragons")
        }
    }
    
    func testToFromJSON(){
        let book1 = Book(checkedOut: true, title: "Design Patterns", author: "Helm", genre: "Non-Fiction", id: 4, checkedOutBy: "Bob")
        let firstLibrary = LibrarySystem(books: [book1])
        do {
            let data = try firstLibrary.toJSON()
            let newLibrary = LibrarySystem(json: data)
            XCTAssertEqual(newLibrary?.books[0].title, firstLibrary.books[0].title)
        } catch {
            XCTAssert(false)
        }
    }
    
    func testToFromJSON1(){
        let book1 = Book(checkedOut: true, title: "Design Patterns", author: "Helm", genre: "Non-Fiction", id: 4, checkedOutBy: "Bob")
        let book2 = Book(checkedOut: true, title: "Designing Dragons", author: "Jeff", genre: "Fiction",  id: 4, checkedOutBy: nil)
        let firstLibrary = LibrarySystem(books: [book1, book2])
        do {
            let data = try firstLibrary.toJSON()
            let newLibrary = LibrarySystem(json: data)
            XCTAssertEqual(newLibrary?.books[0].title, firstLibrary.books[0].title)
            XCTAssertEqual(newLibrary?.books[1].title, firstLibrary.books[1].title)
        } catch {
            XCTAssert(false)
        }
    }
    
    
}
