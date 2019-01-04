//
//  SetFlashCardViewController.swift
//  FlashCards
//
//  Created by user on 18/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SetFlashCardViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var myTextView: MyTextView!
    @IBOutlet weak var warning: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var delegate: Delegate!
    var category: Category!
    var flashCard: FlashCard?
    
    private var isSetQuestionMode = true
    private var question = ""
    private var answer = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let flashCard = flashCard {
            question = flashCard.question
            answer = flashCard.answer
        }
        setContentView()
        setMyTextView()
        warning.isHidden = true
    }
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        if !SetFlashCardWorker().isValid(myTextView.text) {
            warning.isHidden = false
            return
        }
        
        if isSetQuestionMode {
            question = myTextView.text
            flip()
        } else {
            answer = myTextView.text
            if let flashCard = flashCard {
                SetFlashCardWorker().updateFlashCard(flashCard, withQuestion: question, withAnswer: answer)
            } else {
                SetFlashCardWorker().addFlashCard(toCategory: category, withQuestion: question, withAnswer: answer)
            }
            goBack()
        }
    }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        goBack()
    }
    
    private func setContentView() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    
    private func setMyTextView() {
        myTextView.initialize(with: self)
        myTextView.text = question
        myTextView.becomeFirstResponder()
    }
    
    private func flip() {
        UIView.transition(with: contentView, duration: AnimationConstants.Flip.duration, options: AnimationConstants.Flip.options, animations: nil, completion: nil)
        isSetQuestionMode = !isSetQuestionMode
        
        DelayedCall.call(with: AnimationConstants.Flip.duration / 2) {
            self.titleLabel.text = self.isSetQuestionMode ? Names.setFlashCardTitle_Question : Names.setFlashCardTitle_Answer
            self.myTextView.text = self.isSetQuestionMode ? self.question : self.answer
            let buttonTitle = self.isSetQuestionMode ? Names.setFlashCardButtonTitle_Question : Names.setFlashCardButtonTitle_Answer
            self.button.setTitle(buttonTitle, for: .normal)
        }
    }
    
    private func goBack() {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
        delegate.notify()
    }
}

extension SetFlashCardViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if !textView.text.isEmpty {
             warning.isHidden = true
        }
    }
}
