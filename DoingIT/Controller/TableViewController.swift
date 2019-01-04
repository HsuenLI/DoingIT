//
//  ViewController.swift
//  DoingIT
//
//  Created by Hsuen-Ju Li on 2019/1/4.
//  Copyright © 2019 Hsuen-Ju Li. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController{

    //Temperary array
    let things : [Items] = [Items(itemName: "Writting",check : false), Items(itemName: "Playing",check : false), Items(itemName: "Shopping",check : false)]
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "等待事項"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        tableView.rowHeight = 60
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
    }

    @objc func handleAdd(){
        print("add pressed")
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
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        guard let check = cell.item?.check else {return}
        cell.item?.check = check ? false : true
    }
}
