//
//  SetFlashCardQuestionViewController.swift
//  FlashCards
//
//  Created by user on 18/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SetFlashCardQuestionViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var myTextView: MyTextView!
    @IBOutlet weak var warning: UILabel!
    
    weak var flashCardsVC: UIViewController!
    var delegate: Delegate!
    var category: Category!
    var flashCard: FlashCard?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonTitle()
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        title = Names.setFlashCardQuestionNavigationTitle
        
        myTextView.initialize(with: self)
        if let flashCard = flashCard {
            myTextView.text = flashCard.question
        }
        myTextView.becomeFirstResponder()
        
        warning.isHidden = true
    }
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        let question = myTextView.text
        let worker = SetFlashCardQuestionWorker()
        if worker.isValid(question) {
            warning.isHidden = true
            SetFlashCardQuestionRouter(controller: self, flashCardsVC: flashCardsVC, question: question!, category: self.category, flashCard: flashCard).routeToSetFlashCardAnswer()
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
        delegate.notify()
    }
}

extension SetFlashCardQuestionViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if !textView.text.isEmpty {
             warning.isHidden = true
        }
    }
}
