//
//  CategoryListRouter.swift
//  FlashCards
//
//  Created by user on 18/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class CategoryListRouter {
    
    private weak var controller: UIViewController!
    private weak var category: Category?
    
    init(controller: UIViewController, category: Category? = nil) {
        self.controller = controller
        self.category = category
    }
    
    func routeToSetCategory() {
        let vc = instantiateVC(withId: Names.setCategoryViewController) as! SetCategoryViewController
        vc.category = category
        controller.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToFlashCards() {
        let vc = instantiateVC(withId: Names.flashCardsViewController) as! FlashCardsViewController
        vc.category = category
        controller.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func instantiateVC(withId id: String) -> UIViewController {
        return UIStoryboard.init(name: Names.storyBoard, bundle: Bundle.main).instantiateViewController(withIdentifier: id)
    }
}
