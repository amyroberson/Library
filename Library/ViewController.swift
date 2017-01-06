//
//  ViewController.swift
//  Library
//
//  Created by Amy Roberson on 1/5/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let bookStore = BookStore()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookStore.fetchGlobalBooks { result in
            print(result)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

