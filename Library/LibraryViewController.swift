//
//  ViewController.swift
//  Library
//
//  Created by Amy Roberson on 1/5/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController, UITextFieldDelegate {
    let bookStore = BookStore()
    var checkOutPostObject = CheckOutPost()
    var returnPostObject = ReturnPost()
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
        checkOutTextField.delegate = self
        returnTextField.delegate = self
        bookStore.fetchGlobalBooks { result in
            switch result {
            case .success(let bookResults):
                self.library = LibrarySystem(books: bookResults)
                if let books = self.library {
                    self.currentBook = books.books[self.index]
                    self.refresh()
                }
            case .failure(let error):
                print("\(result) \(error)")
            }
        }
        
        
    }
    
    // keeps user from entering text at the wrong time
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let currentCheckedOut = currentBook?.checkedOut ?? false
        
        switch textField{
        case checkOutTextField:
            if !currentCheckedOut {
                if currentBook != nil {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        case returnTextField:
            if currentCheckedOut {
                return true
            } else {
                return false
            }
        default:
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        // need to send post request in each
        switch textField {
        case checkOutTextField:
            currentBook!.checkedOut = true
            currentBook!.checkedOutBy = textField.text
            if let name = textField.text {
                let checkOutData: [String:Any] = [
                    "title" : currentBook!.title,
                    "checkedOutBy" : name
                    ]
                let checkOutJson = try! JSONSerialization.data(withJSONObject: checkOutData
                    , options: [])
                
                checkOutPostObject.pushGlobalPost(json: checkOutJson){ result in
                    switch result{
                    case let .success(book):
                        self.library?.books[self.index] = book
                    default:
                        print("\(result)")
                    }
                }
                 refresh()
                
            }
        case returnTextField:
            // later will need to verify return user name but now anyone can return the book
            currentBook?.checkedOut = false
            if let name = currentBook!.checkedOutBy {
                let returnData: [String:Any] = [
                    "title" : currentBook!.title,
                    "checkedOutBy": name
                    //"returnedBy" : returnTextField.text used later for validation
                ]
                let returnJson = try! JSONSerialization.data(withJSONObject: returnData
                    , options: [])
                
                
                returnPostObject.pushGlobalPost(json: returnJson){ result in
                    switch result{
                    case let .success(book):
                         self.library?.books[self.index] = book
                    default:
                        print(result)
                        
                    }
                }
                refresh()
            }
            
        default:
            print("Somehow a new text field was used")
        }
        return false
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text?.isEmpty ?? true {
            return false
        }
        return true
    }
    
    @IBAction func previousBookButton(_ sender: UIButton) {
        if let count = library?.books.count {
            if index - 1 >= 0 {
                index -= 1
            } else {
                index = count - 1
            }
        }
        currentBook = library?.books[index]
         refresh()
    }
    
    @IBAction func nextBookButton(_ sender: UIButton) {
        //update current user
        if let count = library?.books.count {
            if index + 1 < count {
                index += 1
            } else {
                index = 0
            }
        }
        currentBook = library?.books[index]
        refresh()
    }
    
    func refresh(){
        guard Thread.current.isMainThread else {
            
            self.perform(#selector(refresh), on: Thread.main, with: nil, waitUntilDone: false)
            return
        }
        titleLabel.text = currentBook?.title
        authorLabel.text = currentBook?.author
        genreLabel.text = currentBook?.genre
        idLabel.text = "ID: \((currentBook?.id)!)"
        checkedOutNameLabel.text = currentBook?.checkedOutBy
        
    }
    
    

}

