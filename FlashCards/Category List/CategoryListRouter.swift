//
//  CategoryListRouter.swift
//  FlashCards
//
//  Created by user on 18/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class CategoryListRouter {
    
    static func routeToSetCategory(from controller: CategoryListViewController) {
        controller.performSegue(withIdentifier: Names.setCategorySegue, sender: controller)
    }
    
    static func sendParamsToSetCategory(_ delegate: Delegate, _ segue: UIStoryboardSegue, _ category: Category?) {
        if segue.identifier == Names.setCategorySegue  {
            if let destination = segue.destination as? SetCategoryViewController {
                destination.category = category
                destination.delegate = delegate
            }
        }
    }
    
    static func routeToFlashCards(from controller: CategoryListViewController, _ category: Category?) {
        let vc = UIStoryboard.init(name: Names.storyBoard, bundle: Bundle.main).instantiateViewController(withIdentifier: Names.flashCardsViewController) as! FlashCardsViewController
        vc.category = category
        controller.navigationController?.pushViewController(vc, animated: true)
    }
}
