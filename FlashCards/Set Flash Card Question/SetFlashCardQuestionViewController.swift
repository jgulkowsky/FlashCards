//
//  SetFlashCardQuestionViewController.swift
//  FlashCards
//
//  Created by user on 18/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SetFlashCardQuestionViewController: UIViewController {

    @IBOutlet weak var myTextView: MyTextView!
    @IBOutlet weak var warning: UILabel!
    
    weak var flashCardsVC: UIViewController!
    var category: Category!
    var flashCard: FlashCard?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonTitle()
        
        title = Names.setFlashCardQuestionNavigationTitle
        
        myTextView.initialize(with: self)
        if let flashCard = flashCard {
            myTextView.text = flashCard.question
        }
        
        warning.isHidden = true
        
        myTextView.becomeFirstResponder()
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
}

extension SetFlashCardQuestionViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if !textView.text.isEmpty {
             warning.isHidden = true
        }
    }
}
