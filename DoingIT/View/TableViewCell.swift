//
//  TableViewCell.swift
//  代辦事項
//
//  Created by Hsuen-Ju Li on 2019/1/4.
//  Copyright © 2019 Hsuen-Ju Li. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //Outlets
    var item : Item?{
        didSet{
            listLabel.text = item?.itemName
            tickImageView.isHidden = (item?.check)! ? false : true
        }
    }
    
    let listLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    let tickImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tick")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.darkGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(listLabel)
        addSubview(tickImageView)
        
        listLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

        tickImageView.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 20, height: 20)
        tickImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

extension UIView{
    
    func anchor(top : NSLayoutYAxisAnchor?, left : NSLayoutXAxisAnchor?, bottom : NSLayoutYAxisAnchor?, right : NSLayoutXAxisAnchor?, paddingTop : CGFloat, paddingLeft : CGFloat, paddingBottom : CGFloat, paddingRight : CGFloat, width : CGFloat, height : CGFloat){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left{
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right{
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0{
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0{
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
}
