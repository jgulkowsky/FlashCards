//
//  SetFlashCardQuestionRouter.swift
//  FlashCards
//
//  Created by user on 20/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SetFlashCardQuestionRouter {
    
    private weak var controller: UIViewController!
    private weak var flashCardsVC: UIViewController!
    private var question: String!
    private var category: Category!
    private var flashCard: FlashCard?
    
    init(controller: UIViewController, flashCardsVC: UIViewController, question: String, category: Category, flashCard: FlashCard? = nil) {
        self.controller = controller
        self.flashCardsVC = flashCardsVC
        self.question = question
        self.category = category
        self.flashCard = flashCard
    }
    
    func routeToSetFlashCardAnswer() {
        let vc = UIStoryboard.init(name: Names.storyBoard, bundle: Bundle.main).instantiateViewController(withIdentifier: Names.setFlashCardAnswerViewController) as! SetFlashCardAnswerViewController
        vc.flashCardsVC = flashCardsVC
        vc.question = question
        vc.category = category
        vc.flashCard = flashCard
        controller.navigationController?.pushViewController(vc, animated: true)
    }
}

