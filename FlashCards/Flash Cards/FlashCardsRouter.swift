//
//  FlashCardsRouter.swift
//  FlashCards
//
//  Created by user on 20/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class FlashCardsRouter {
    
    private weak var controller: UIViewController!
    private weak var category: Category!
    private weak var flashCard: FlashCard?
    
    init(controller: UIViewController, category: Category, flashCard: FlashCard? = nil) {
        self.controller = controller
        self.category = category
        self.flashCard = flashCard
    }
    
    func routeToSetFlashCard() {
        let vc = UIStoryboard.init(name: Names.storyBoard, bundle: Bundle.main).instantiateViewController(withIdentifier: Names.setFlashCardViewController) as! SetFlashCardViewController
        vc.category = category
        vc.flashCard = flashCard
        controller.navigationController?.pushViewController(vc, animated: true)
    }
}
