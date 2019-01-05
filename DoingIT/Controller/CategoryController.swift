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
    }
    
    @objc func handleAddButton(){
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
