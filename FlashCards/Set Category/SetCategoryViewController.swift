//
//  SetCategoryViewController.swift
//  FlashCards
//
//  Created by user on 18/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SetCategoryViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var warning: UILabel!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    var delegate: Delegate!
    var category: Category?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        if let category = category {
            textField.text = category.title
        }
        textField.becomeFirstResponder()
        
        warning.isHidden = true
        tapGesture.delegate = self
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
            goBack()
        } else {
            warning.isHidden = false
        }
    }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        goBack()
    }
    
    private func goBack() {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
        delegate.notify(with: nil)
    }
}

extension SetCategoryViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return !contentView.bounds.contains(touch.location(in: contentView))
    }
}
