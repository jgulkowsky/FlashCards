//
//  CategoryListWorker.swift
//  FlashCards
//
//  Created by user on 18/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryListWorker {
    
    let realm = try! Realm()
    
    func getCategoryList() -> Results<Category> {
        return realm.objects(Category.self).sorted(byKeyPath: "date", ascending: true)
    }
    
    func deleteCategory(_ category: Category) {
        do {
            try realm.write {
                realm.delete(category)
            }
        } catch {
            print("Error deleting category \(error)")
        }
    }
}
