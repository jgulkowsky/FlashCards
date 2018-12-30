//
//  SetCategoryWorker.swift
//  FlashCards
//
//  Created by user on 20/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import RealmSwift

class SetCategoryWorker {
    
    private let realm = try! Realm()
    
    func isValid(_ title: String?) -> Bool {
        return title != nil && title! != ""
    }
    
    func addCategory(withTitle title: String) {
        do {
            try realm.write {
                let category = Category()
                category.title = title
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
    }
    
    func updateCategory(_ category: Category, withTitle title: String) {
        do {
            try realm.write {
                category.title = title
            }
        } catch {
            print("Error updating category \(error)")
        }
    }
}
