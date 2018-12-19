//
//  CategoryListRouter.swift
//  FlashCards
//
//  Created by user on 18/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class CategoryListRouter {
    
    private weak var controller: UIViewController?
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func routeToSetCategory() {
        let vc = instantiateVC(withId: Names.setCategoryViewController)
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToFlashCards() {
        let vc = instantiateVC(withId: Names.flashCardsViewController)
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func instantiateVC(withId id: String) -> UIViewController {
        return UIStoryboard.init(name: Names.storyBoard, bundle: Bundle.main).instantiateViewController(withIdentifier: id)
    }
}
