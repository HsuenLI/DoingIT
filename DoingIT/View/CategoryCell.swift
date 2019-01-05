//
//  CategoryCell.swift
//  待辦事項
//
//  Created by Hsuen-Ju Li on 2019/1/5.
//  Copyright © 2019 Hsuen-Ju Li. All rights reserved.
//

import UIKit

class CategoryCell : UITableViewCell {
    
    //Outlets
    
    var category : CategoryItem?{
        didSet{
            title.text = category?.title
        }
    }
    
    let title : UILabel = {
        let label = UILabel()
        label.text = "Title Name"
        label.textColor = UIColor.darkGray
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    let arrowImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.darkGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(arrowImageView)
        arrowImageView.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 10, height: 10)
        arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addSubview(title)
        title.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: arrowImageView.leftAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
