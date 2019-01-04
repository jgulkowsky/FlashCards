//
//  FlashCardsRouter.swift
//  FlashCards
//
//  Created by user on 20/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class FlashCardsRouter {

    static func routeToSetFlashCard(from controller: FlashCardsViewController) {
        controller.performSegue(withIdentifier: Names.setFlashCardSegue, sender: controller)
    }
    
    static func sendParamsToSetFlashCard(_ delegate: Delegate, _ segue: UIStoryboardSegue, _ category: Category, _ flashCard: FlashCard?) {
        if segue.identifier == Names.setFlashCardSegue  {
            if let destination = segue.destination as? SetFlashCardViewController {
                destination.delegate = delegate
                destination.category = category
                destination.flashCard = flashCard
            }
        }
    }
}
