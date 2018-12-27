//
//  SetFlashCardAnswerViewController.swift
//  FlashCards
//
//  Created by user on 22/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SetFlashCardAnswerViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var warning: UILabel!
    
    weak var flashCardsVC: UIViewController!
    var question: String!
    var category: Category!
    var flashCard: FlashCard?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBackButtonTitle()
        
        title = Names.setFlashCardAnswerNavigationTitle
        
        if let flashCard = flashCard {
            textView.text = flashCard.answer
        }
        
        warning.isHidden = true
    }
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        let answer = textView.text
        let worker = SetFlashCardAnswerWorker()
        if worker.isValid(answer) {
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
