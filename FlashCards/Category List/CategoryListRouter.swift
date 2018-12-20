//
//  CategoryListRouter.swift
//  FlashCards
//
//  Created by user on 18/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class CategoryListRouter {
    
    private weak var controller: CategoryListViewController?
    private var category: Category?
    
    init(controller: CategoryListViewController, category: Category? = nil) {
        self.controller = controller
        self.category = category
    }
    
    func routeToSetCategory() {
        let vc = instantiateVC(withId: Names.setCategoryViewController) as! SetCategoryViewController
        if let category = category {
            send(category, to: vc)
        }
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToFlashCards() {
        let vc = instantiateVC(withId: Names.flashCardsViewController) as! FlashCardsViewController
        send(category!, to: vc)
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func instantiateVC(withId id: String) -> UIViewController {
        return UIStoryboard.init(name: Names.storyBoard, bundle: Bundle.main).instantiateViewController(withIdentifier: id)
    }
    
    private func send(_ category: Category, to destinationVC: SetCategoryViewController) {
        destinationVC.category = category
    }
    
    private func send(_ category: Category, to destinationVC: FlashCardsViewController) {
        destinationVC.category = category
    }
}
