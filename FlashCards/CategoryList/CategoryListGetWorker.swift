//
//  CategoryListGetWorker.swift
//  FlashCards
//
//  Created by user on 18/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

class CategoryListGetWorker {
    
    private var delegate: CategoryListGetWorkerDelegate
    
    init(delegate: CategoryListGetWorkerDelegate) {
        self.delegate = delegate
    }
    
    func getCategoryList() {
        //TODO: Get data from db
        
        //for now data is mocked
        var categoryList = [CategoryListModels.Category]()
        categoryList.append(CategoryListModels.Category(id: "0", title: "Math"))
        categoryList.append(CategoryListModels.Category(id: "1", title: "English"))
        categoryList.append(CategoryListModels.Category(id: "2", title: "Biology"))
        categoryList.append(CategoryListModels.Category(id: "3", title: "Chemistry"))
        
        delegate.getCategoryList(categoryList)
    }
    
}
