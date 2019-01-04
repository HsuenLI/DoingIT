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

    //Temperary array
    var things : [Items] = [Items(itemName: "Writting",check : false), Items(itemName: "Playing",check : false), Items(itemName: "Shopping",check : false)]
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "等待事項"
        navigationController?.navigationBar.tintColor = UIColor.darkGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
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
            guard let text = textInput.text else {return}
            self.things.append(Items(itemName: text, check: false))
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        present(alert, animated:  true)
    }

}

//MARK: TableView Data source and delegate
extension TableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return things.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        cell.item = things[indexPath.item]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        things[indexPath.row].check = things[indexPath.row].check ? false : true
        tableView.reloadData()
    }
}
