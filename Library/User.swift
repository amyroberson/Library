//
//  User.swift
//  Library
//
//  Created by Amy Roberson on 1/5/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import Foundation

public struct User {
    let userName: String
    let firstName: String
    let lastName: String
    let id: Int
    
   public init(userName: String, firstName: String, lastName: String, id: Int){
        self.userName = userName
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
    }
    
   internal init?(dictionary:[String: Any]){
        guard let userName = dictionary["userName"] as? String,
            let firstName = dictionary["firstName"] as? String,
            let lastName = dictionary["lastName"] as? String,
            let id = dictionary["id"] as? Int else {
                return nil
        }
        self.init(userName: userName, firstName: firstName, lastName: lastName, id: id)
    }
    
    internal func toDictionary() -> [String: Any] {
        let dictionary: [String: Any] = [
            "userName" : self.userName,
            "firstName" : self.firstName,
            "lastName" : self.lastName,
            "id" : self.id]
        return dictionary
    }
}
