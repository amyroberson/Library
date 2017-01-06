//
//  APIURL.swift
//  Library
//
//  Created by Amy Roberson on 1/5/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import Foundation


internal struct APIURL {
    internal enum Error: Swift.Error {
        case invalidJSONData
    }
    
    internal static let globalStreamURL: URL = URL(string: "https://tiy-todo-angular.herokuapp.com/get-all-books.json")!
    
}
