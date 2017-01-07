//
//  ViewController.swift
//  Library
//
//  Created by Amy Roberson on 1/5/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController {
    let bookStore = BookStore()
    let checkOut = CheckOutPost()
    var index: Int = 0
    var currentBook: Book?
    var library: LibrarySystem?
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var checkedOutByLabel: UILabel!
    @IBOutlet var checkedOutNameLabel: UILabel!
    @IBOutlet var instructionCheckOutLabel: UILabel!
    @IBOutlet var instructionReturnLabel: UILabel!
    @IBOutlet var checkOutTextField: UITextField!
    @IBOutlet var returnTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookStore.fetchGlobalBooks { result in
            switch result {
            case .success(let bookResults):
                self.library = LibrarySystem(books: bookResults)
            case .failure(let error):
                print(error)
            } // now books should be collected and stored in libraryBooks
        }
        
        if let books = library {
            currentBook = books.books[index]
        }
        
        //checkOut.pushGlobalPost()
    }
    
    @IBAction func previousBookButton(_ sender: UIButton) {
        //update current user
    }
    
    @IBAction func nextBookButton(_ sender: UIButton) {
        //update current user
    }
    
    func refresh(){
        
    }
    
    

}

