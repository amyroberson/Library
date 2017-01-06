//
//  UserMethodTests.swift
//  Library
//
//  Created by Amy Roberson on 1/5/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import XCTest
@testable import Library

class UserMethodTests: XCTestCase {
    
    func testINIT1(){
        let user1 = User(userName: "Kupri", firstName: "Amy", lastName: "Roberson", id: 0001)
        XCTAssertEqual(user1.id, 0001)
        XCTAssertEqual(user1.userName, "Kupri")
        XCTAssertEqual(user1.firstName, "Amy")
        XCTAssertEqual(user1.lastName, "Roberson")
    }
    
    func testFailableINIT(){
        let dictionary: [String: Any] = [
            "userName" : "Kupri",
            "firstName" : "Amy",
            "lastName" : "Roberson",
            "id" : 0001]
        let user1 = User(dictionary: dictionary)
        XCTAssertEqual(user1?.id, 0001)
        XCTAssertEqual(user1?.userName, "Kupri")
        XCTAssertEqual(user1?.firstName, "Amy")
        XCTAssertEqual(user1?.lastName, "Roberson")
        
    }
    
    func testToDictionary(){
        let user1 = User(userName: "Kupri", firstName: "Amy", lastName: "Roberson", id: 0001)
        let newDictionary = user1.toDictionary()
        if let userName: String = newDictionary["userName"] as? String,
            let firstName: String = newDictionary["firstName"] as? String,
            let lastName: String = newDictionary["lastName"] as? String,
            let id: Int = newDictionary["id"] as? Int {
            XCTAssertEqual(userName, user1.userName)
            XCTAssertEqual(firstName, user1.firstName)
            XCTAssertEqual(lastName, user1.lastName)
            XCTAssertEqual(id, user1.id)
        }
        
    }
    
}
