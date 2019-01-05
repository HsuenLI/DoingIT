//
//  ViewController.swift
//  DoingIT
//
//  Created by Hsuen-Ju Li on 2019/1/4.
//  Copyright © 2019 Hsuen-Ju Li. All rights reserved.
//

import UIKit
import CoreData


class TableViewController: UITableViewController, UISearchBarDelegate{

    //Variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items = [Item]()
    let cellId = "cellId"
    var selectedCategory : CategoryItem?{
        didSet{
            loadItem()
        }
    }
    
    //Outlets
    lazy var searchBar : UISearchBar = {
        let sb = UISearchBar(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        sb.placeholder = "Input for search..."
        sb.delegate = self
        sb.backgroundImage = UIImage()
        sb.layer.borderWidth = 0.5
        sb.layer.borderColor = UIColor.lightGray.cgColor

        return sb
    }()
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = "等待事項"
        navigationController?.navigationBar.tintColor = UIColor.darkGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
    }
    
    fileprivate func setupSearchBar(){
        tableView.tableHeaderView = searchBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        //print core data file place
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        tableView.backgroundColor = .white
        tableView.rowHeight = 60
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        setupSearchBar()
    }

    @objc func handleAdd(){
        var textInput = UITextField()
        let alert = UIAlertController(title: "新事項", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "請輸入新事項"
            textInput = textField
        }
        
        let action = UIAlertAction(title: "加入", style: .default) { (action) in
            
            let item = Item(context: self.context)
            guard let text = textInput.text else {return}
            item.itemName = text
            item.check = false
            item.parentCategory = self.selectedCategory
            self.items.append(item)
            self.tableView.saveItem()
        }
        
        alert.addAction(action)
        present(alert, animated:  true)
    }
    

    func loadItem(request : NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil){
        //let request : NSFetchRequest<Item> = Item.fetchRequest()
        guard let selecteCategoryTitle = selectedCategory?.title else {return}
        let categoryPredicate = NSPredicate(format: "parentCategory.title MATCHES %@", selecteCategoryTitle)
        
        if let additionalPredicate = predicate{
            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
            
            request.predicate = compoundPredicate
            
        }else{
            request.predicate = categoryPredicate
        }
    
        do{
            items = try self.context.fetch(request)
        }catch{
            print("Failed to fetch data from core data:", error)
        }
        tableView.reloadData()
    }
    
    //Swipe with delete option
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completeHandler) in
            self.context.delete(self.items[indexPath.item])
            self.items.remove(at: indexPath.item)
            tableView.saveItem()
            
            completeHandler(true)
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfiguration
    }
    
}

//MARK: TableView Data source and delegate
extension TableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        cell.item = items[indexPath.item]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        items[indexPath.row].check = items[indexPath.row].check ? false : true
        tableView.saveItem()
    }
}


extension TableViewController{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0{
            loadItem()
            
            //No Matter the task is running, if empty running dismiss keyboard
            DispatchQueue.main.async {
                //If empty, dismiss keyboard
                searchBar.resignFirstResponder()
            }
        }else{
            let request : NSFetchRequest<Item> = Item.fetchRequest()
            let predicate = NSPredicate(format: "itemName CONTAINS[cd] %@", searchBar.text!)
            request.predicate = predicate
            request.sortDescriptors = [NSSortDescriptor(key: "itemName", ascending: true)]
            
            loadItem(request : request, predicate: predicate)
        }

//        do{
//            items = try self.context.fetch(request)
//        }catch{
//            print("Failed to fetch data from core data:", error)
//        }
//
//        tableView.reloadData()
    }
}
