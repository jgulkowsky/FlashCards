//
//  SetFlashCardAnswerViewController.swift
//  FlashCards
//
//  Created by user on 22/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SetFlashCardAnswerViewController: UIViewController {
    
    @IBOutlet weak var myTextView: MyTextView!
    @IBOutlet weak var warning: UILabel!
    
    weak var flashCardsVC: UIViewController!
    var question: String!
    var category: Category!
    var flashCard: FlashCard?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonTitle()
        
        title = Names.setFlashCardAnswerNavigationTitle
        
        myTextView.initialize(with: self)
        myTextView.setPlaceholderMode(with: Names.setFlashCardAnswerPlaceholder)
        if let flashCard = flashCard {
            myTextView.setTextMode(with: flashCard.answer)
        }
        
        warning.isHidden = true
    }
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        view.endEditing(true)
        let answer = myTextView.text
        let worker = SetFlashCardAnswerWorker()
        if worker.isValid(answer) && !myTextView.isInPlaceholderMode {
            warning.isHidden = true
            if let flashCard = flashCard {
                SetFlashCardAnswerWorker().updateFlashCard(flashCard, withQuestion: question, withAnswer: answer!)
            } else {
                SetFlashCardAnswerWorker().addFlashCard(toCategory: category, withQuestion: question, withAnswer: answer!)
            }
            SetFlashCardAnswerRouter(controller: self, toController: flashCardsVC).routeToFlashCards()
        } else {
            warning.isHidden = false
        }
    }
}

extension SetFlashCardAnswerViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if myTextView.isInPlaceholderMode {
            myTextView.setTextMode()
        }
        warning.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if myTextView.text.isEmpty {
            myTextView.setPlaceholderMode(with: Names.setFlashCardAnswerPlaceholder)
        }
    }
}
