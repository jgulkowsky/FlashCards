//
//  CategoryListViewController.swift
//  FlashCards
//
//  Created by user on 18/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

protocol CategoryListGetWorkerDelegate {
    func getCategoryList(_ categoriesTitles: [CategoryListModels.Category])
}

class CategoryListViewController: UITableViewController {
    
    private var categoryList: [CategoryListModels.Category] = []
    
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
        routeToFlashCards()
    }
}

extension CategoryListViewController {
    
    private func requestForCategoryList() {
        let worker = CategoryListGetWorker(delegate: self)
        worker.getCategoryList()
    }
    
    private func routeToSetCategoryTitle() {
        //TODO: We need to send category title and id if it's set not add
        let router = CategoryListRouter(controller: self)
        router.routeToSetCategory()
    }
    
    private func routeToFlashCards() {
        //TODO: We need to send category title and id
        let router = CategoryListRouter(controller: self)
        router.routeToFlashCards()
    }
    
    private func returnTableViewCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Names.categoryListCell, for: indexPath) as! UITableViewCell
        cell.textLabel?.text = categoryList[indexPath.row].title
        return cell
    }
}

extension CategoryListViewController: CategoryListGetWorkerDelegate {
    func getCategoryList(_ categoryList: [CategoryListModels.Category]) {
        self.categoryList = categoryList
        tableView.reloadData()
    }
}

