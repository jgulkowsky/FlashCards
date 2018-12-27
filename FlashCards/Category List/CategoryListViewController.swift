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
        setBackButtonTitle()
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
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            CategoryListWorker().deleteCategory(self.categoryList![index.row])
            tableView.reloadData()
        }
        delete.backgroundColor = .red
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            CategoryListRouter(controller: self, category: self.categoryList![index.row])
                .routeToSetCategory()
        }
        edit.backgroundColor = .blue
        
        return [delete, edit]
    }
}
