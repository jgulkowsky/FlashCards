//
//  CategoryListViewController.swift
//  FlashCards
//
//  Created by user on 18/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryListViewController: UITableViewController, Delegate {
    
    private var categoryList: Results<Category>?
    private var categoryToSend: Category?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onInit()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Names.categoryListCell, for: indexPath)
        cell.textLabel?.text = categoryList?[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CategoryListRouter.routeToFlashCards(from: self, categoryList![indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .normal, title: Names.categoryListCellDeleteTitle) { action, index in
            CategoryListWorker().deleteCategory(self.categoryList![index.row])
            tableView.deleteRows(at: [index], with: UITableView.RowAnimation.left)
        }
        delete.backgroundColor = ColorHelper.uicolorFromHex(GeneralConstants.HexColors.red)
        
        let edit = UITableViewRowAction(style: .normal, title: Names.categoryListCellEditTitle) { action, index in
            self.categoryToSend = self.categoryList![index.row]
            CategoryListRouter.routeToSetCategory(from: self)
        }
        edit.backgroundColor = ColorHelper.uicolorFromHex(GeneralConstants.HexColors.blue)
        
        return [delete, edit]
    }
    
    @IBAction func onAddButtonPressed(_ sender: UIBarButtonItem) {
        CategoryListRouter.routeToSetCategory(from: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        CategoryListRouter.sendParamsToSetCategory(self, segue, categoryToSend)
    }
    
    func notify(with params: Any?) {
        onInit()
    }
    
    private func onInit() {
        categoryToSend = nil
        setBackButtonTitle()
        categoryList = CategoryListWorker().getCategoryList()
        tableView.reloadData()
    }
}
