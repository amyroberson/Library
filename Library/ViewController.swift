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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //bookStore.fetchGlobalBooks { result in
        //    print(result)
        //}
        
        checkOut.pushGlobalPost()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

