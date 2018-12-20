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
        return realm.objects(Category.self)
    }
    
}
