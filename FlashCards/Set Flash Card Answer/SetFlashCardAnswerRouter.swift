//
//  SetFlashCardAnswerRouter.swift
//  FlashCards
//
//  Created by user on 22/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SetFlashCardAnswerRouter {
    
    private weak var controller: UIViewController!
    private weak var destination: UIViewController!
    
    init(controller: UIViewController, toController destination: UIViewController) {
        self.controller = controller
        self.destination = destination
    }
    
    func routeToFlashCards() {
        controller.navigationController?.popToViewController(destination, animated: true)
    }
}
