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
        myTextView.setPlaceholderMode(with: Names.setFlashCardQuestionPlaceholder)
        if let flashCard = flashCard {
            myTextView.setTextMode(with: flashCard.question)
        }
        
        warning.isHidden = true
    }
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        view.endEditing(true)
        let question = myTextView.text
        let worker = SetFlashCardQuestionWorker()
        if worker.isValid(question) && !myTextView.isInPlaceholderMode {
            warning.isHidden = true
            SetFlashCardQuestionRouter(controller: self, flashCardsVC: flashCardsVC, question: question!, category: self.category, flashCard: flashCard).routeToSetFlashCardAnswer()
        } else {
            warning.isHidden = false
        }
    }
}

extension SetFlashCardQuestionViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if myTextView.isInPlaceholderMode {
            myTextView.setTextMode()
        }
        warning.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if myTextView.text.isEmpty {
            myTextView.setPlaceholderMode(with: Names.setFlashCardQuestionPlaceholder)
        }
    }
}
