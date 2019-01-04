//
//  FlashCardsRouter.swift
//  FlashCards
//
//  Created by user on 20/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class FlashCardsRouter {

    static func routeToSetFlashCardQuestion(from controller: FlashCardsViewController) {
        controller.performSegue(withIdentifier: Names.setFlashCardQuestionSegue, sender: controller)
    }
    
    static func sendParamsToSetFlashCardQuestion(_ delegate: Delegate, _ controller: FlashCardsViewController, _ segue: UIStoryboardSegue, _ category: Category, _ flashCard: FlashCard?) {
        if segue.identifier == Names.setFlashCardQuestionSegue  {
            if let destination = segue.destination as? SetFlashCardQuestionViewController {
                destination.delegate = delegate
                destination.flashCardsVC = controller
                destination.category = category
                destination.flashCard = flashCard
            }
        }
    }
}
