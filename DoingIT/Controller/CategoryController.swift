//
//  CategoryController.swift
//  待辦事項
//
//  Created by Hsuen-Ju Li on 2019/1/5.
//  Copyright © 2019 Hsuen-Ju Li. All rights reserved.
//

import UIKit
import CoreData

class CategoryController : UITableViewController {
    
    let cellId = "cellId"
    var categories = [CategoryItem]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var listController = TableViewController()
    var items = [Item]()
    
    fileprivate func setupNavigation(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddButton))
        navigationController?.navigationBar.tintColor = UIColor.darkGray
        navigationItem.title = "總項目"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        
        tableView.rowHeight = 60
        tableView.register(CategoryCell.self, forCellReuseIdentifier: cellId)
        
        loadCategory()
    }
    
    @objc func handleAddButton(){
        var inputTextField = UITextField()
        let alert = UIAlertController(title: "新項目", message: nil, preferredStyle: .alert)
        alert.addTextField { (textfield) in
            textfield.placeholder = "請輸入項目名稱"
            inputTextField = textfield
        }
        
        let addAction = UIAlertAction(title: "加入", style: .default) { (action) in
            if inputTextField.text?.count == 0{
                self.dismiss(animated: true, completion: nil)
            }else{
                let category = CategoryItem(context: self.context)
                category.title = inputTextField.text
                self.categories.append(category)
                self.tableView.saveItem()
            }

        }
        
        let deleteAction = UIAlertAction(title: "取消", style: .destructive, handler: nil)
        
        
        alert.addAction(addAction)
        alert.addAction(deleteAction)
        present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CategoryCell
        cell.category = categories[indexPath.item]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        listController.selectedCategory = categories[indexPath.item]
        navigationController?.pushViewController(listController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completeHandler) in
            let categoryName = self.categories[indexPath.item]
            self.context.delete(categoryName)
            self.categories.remove(at: indexPath.item)
            self.tableView.saveItem()
            completeHandler(true)
        }
        let swipeConfigulation = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfigulation
    }
    
    
    func loadCategory(){
        let request : NSFetchRequest<CategoryItem> = CategoryItem.fetchRequest()
        
        do{
            categories = try self.context.fetch(request)
        }catch{
            print("Failed to fetch category data from database:", error)
        }
        
        tableView.reloadData()
    }
    
}

extension UITableView{
    
    func saveItem(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            try context.save()
        }catch{
            print("Failed to save category data into database:" , error)
        }
        
        reloadData()
    }
    
}
