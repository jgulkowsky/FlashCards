//
//  SetFlashCardViewController.swift
//  FlashCards
//
//  Created by user on 18/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SetFlashCardViewController: UIViewController {

    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var warning: UILabel!
    
    var category: Category!
    var flashCard: FlashCard?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = Names.setFlashCardNavigationTitle
        
        if let flashCard = flashCard {
            questionTextView.text = flashCard.question
            answerTextView.text = flashCard.answer
        }
        
        warning.isHidden = true
    }
    @IBAction func onButtonPressed(_ sender: UIButton) {
        let question = questionTextView.text
        let answer = answerTextView.text
        let worker = SetFlashCardWorker()
        if worker.isValid(question) && worker.isValid(answer) {
            warning.isHidden = true
            if let flashCard = flashCard {
                worker.updateFlashCard(flashCard, withQuestion: question!, withAnswer: answer!)
            } else {
                worker.addFlashCard(toCategory: category, withQuestion: question!, withAnswer: answer!)
            }
            SetFlashCardRouter(controller: self).routeToFlashCards()
        } else {
            warning.isHidden = false
        }
    }
}
