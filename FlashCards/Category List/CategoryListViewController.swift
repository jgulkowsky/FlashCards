//
//  CategoryListViewController.swift
//  FlashCards
//
//  Created by user on 18/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryListViewController: UITableViewController {
    
    private var categoryList: Results<Category>?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoryList = CategoryListWorker().getCategoryList()
        tableView.reloadData()
    }
    
    @IBAction func onAddButtonPressed(_ sender: UIBarButtonItem) {
        CategoryListRouter(controller: self).routeToSetCategory()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Names.categoryListCell, for: indexPath) as! UITableViewCell
        cell.textLabel?.text = categoryList?[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CategoryListRouter(controller: self, category: categoryList![indexPath.row])
            .routeToFlashCards()
    }
}
