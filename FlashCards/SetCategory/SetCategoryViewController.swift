//
//  SetCategoryViewController.swift
//  FlashCards
//
//  Created by user on 18/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SetCategoryViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var warning: UILabel!
    
    var category: DataModels.Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Set Category Title"
        
        if let category = category {
            textField.placeholder = category.title
        } else {
            textField.placeholder = "Add title"
        }
        
    }
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        
    }
}
