//
//  SetCategoryRouter.swift
//  FlashCards
//
//  Created by user on 20/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class SetCategoryRouter {
    
    private weak var controller: SetCategoryViewController?
    
    init(controller: SetCategoryViewController) {
        self.controller = controller
    }
    
    func routeToCategoryList() {
        controller?.navigationController?.popViewController(animated: true)
    }
}
