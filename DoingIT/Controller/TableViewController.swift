//
//  ViewController.swift
//  DoingIT
//
//  Created by Hsuen-Ju Li on 2019/1/4.
//  Copyright © 2019 Hsuen-Ju Li. All rights reserved.
//

import UIKit
import CoreData


class TableViewController: UITableViewController{

    //Variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items = [Item]()
    let cellId = "cellId"
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = "等待事項"
        navigationController?.navigationBar.tintColor = UIColor.darkGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    
        //print core data file place
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        tableView.rowHeight = 60
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
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
            self.items.append(item)
            self.saveItem()
        }
        
        alert.addAction(action)
        present(alert, animated:  true)
    }
    
    //Save function
    func saveItem(){
        do{
            try context.save()
        }catch{
            print("Failed to save data into core data:" , error)
        }
        tableView.reloadData()
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
        self.saveItem()
    }
}
