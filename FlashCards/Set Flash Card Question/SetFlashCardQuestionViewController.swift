//
//  SetFlashCardQuestionViewController.swift
//  FlashCards
//
//  Created by user on 18/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SetFlashCardQuestionViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var warning: UILabel!
    
    weak var flashCardsVC: UIViewController!
    var category: Category!
    var flashCard: FlashCard?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBackButtonTitle()
        
        title = Names.setFlashCardQuestionNavigationTitle
        
        if let flashCard = flashCard {
            textView.text = flashCard.question
        }
        
        warning.isHidden = true
    }
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        let question = textView.text
        let worker = SetFlashCardQuestionWorker()
        if worker.isValid(question) {
            warning.isHidden = true
            SetFlashCardQuestionRouter(controller: self, flashCardsVC: flashCardsVC, question: question!, category: self.category, flashCard: flashCard).routeToSetFlashCardAnswer()
        } else {
            warning.isHidden = false
        }
    }
}
