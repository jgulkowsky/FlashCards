//
//  CategoryListModels.swift
//  FlashCards
//
//  Created by user on 19/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

struct CategoryListModels {
    
    struct Category {
        let id: String
        let title: String
        
        init(id: String, title: String) {
            self.id = id
            self.title = title
        }
    }
}
