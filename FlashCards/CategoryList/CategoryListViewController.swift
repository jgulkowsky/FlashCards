//
//  CategoryListViewController.swift
//  FlashCards
//
//  Created by user on 18/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

protocol CategoryListGetWorkerDelegate {
    func getCategoryList(_ categoryList: [DataModels.Category])
}

class CategoryListViewController: UITableViewController {
    
    private var categoryList: [DataModels.Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestForCategoryList()
    }
    
    @IBAction func onAddButtonPressed(_ sender: UIBarButtonItem) {
        routeToSetCategoryTitle()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return returnTableViewCell(for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        routeToFlashCards(withCategory: categoryList[indexPath.row])
    }
}

extension CategoryListViewController {
    
    private func requestForCategoryList() {
        let worker = CategoryListGetWorker(delegate: self)
        worker.getCategoryList()
    }
    
    private func routeToSetCategoryTitle(withCategory category: DataModels.Category? = nil) {
        //TODO: We need to send category title and id if it's set not add
        let router = CategoryListRouter(controller: self, category: category)
        router.routeToSetCategory()
    }
    
    private func routeToFlashCards(withCategory category: DataModels.Category) {
        //TODO: We need to send category title and id
        let router = CategoryListRouter(controller: self, category: category)
        router.routeToFlashCards()
    }
    
    private func returnTableViewCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Names.categoryListCell, for: indexPath) as! UITableViewCell
        cell.textLabel?.text = categoryList[indexPath.row].title
        return cell
    }
}

extension CategoryListViewController: CategoryListGetWorkerDelegate {
    func getCategoryList(_ categoryList: [DataModels.Category]) {
        self.categoryList = categoryList
        tableView.reloadData()
    }
}

