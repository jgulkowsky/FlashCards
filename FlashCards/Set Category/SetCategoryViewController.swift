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
    
    var category: Category?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBackButtonTitle()
        
        title = Names.setCategoryNavigationTitle
        
        if let category = category {
            textField.text = category.title
        }
        
        warning.isHidden = true
    }
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        let title = textField.text
        let worker = SetCategoryWorker()
        if worker.isValid(title) {
            warning.isHidden = true
            if let category = category {
                worker.updateCategory(category, withTitle: title!)
            } else {
                worker.addCategory(withTitle: title!)
            }
            SetCategoryRouter(controller: self).routeToCategoryList()
        } else {
            warning.isHidden = false
        }
    }
}
