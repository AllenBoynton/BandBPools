//
//  Cells.swift
//  B & B Pools
//
//  Created by Allen Boynton on 10/7/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import LBTAComponents

class UserHeader: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            cellImage.image = UIImage(named: "logo")
        }
    }
    
    let dividerLine1: UIView = {
        let line = UIView()
        let myBlue = UIColor.rgb(red: 17, green: 43, blue: 95)
        line.layer.backgroundColor = myBlue.cgColor
        return line
    }()
    
    let cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let dividerLine2: UIView = {
        let line = UIView()
        let myBlue = UIColor.rgb(red: 17, green: 43, blue: 95)
        line.layer.backgroundColor = myBlue.cgColor
        return line
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        
        addSubview(cellImage)
        addSubview(dividerLine1)
        addSubview(dividerLine2)
        
        dividerLine1.anchor(self.topAnchor, left: self.leftAnchor, bottom: cellImage.topAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: frame.width, heightConstant: 2)
        
        let imageWidth: CGFloat = 90.0
        
        cellImage.anchor(dividerLine1.bottomAnchor, left: self.leftAnchor, bottom: dividerLine2.topAnchor, right: nil, topConstant: 8, leftConstant: frame.width / 2 - imageWidth/2, bottomConstant: 8, rightConstant: 0, widthConstant: imageWidth, heightConstant: 40)
        
        dividerLine2.anchor(cellImage.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: frame.width, heightConstant: 2)
    }
}

class UserFooter: DatasourceCell {
    override func setupViews() {
        super.setupViews()
        backgroundColor = .green
    }
}

class UserCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            nameLabel.text = datasourceItem as? String
            cellImage.image = UIImage(named: (datasourceItem as? String)!)
        }
    }
    
    let cellImage: UIImageView = {
        let imageView = UIImageView()
        let myBlue = UIColor.rgb(red: 17, green: 43, blue: 95)
        imageView.layer.borderColor = myBlue.cgColor
        imageView.layer.cornerRadius = 5.0
        imageView.layer.borderWidth = 2.0
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 13.0)
        
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .clear
        
        addSubview(cellImage)
        addSubview(nameLabel)
        
        cellImage.anchor(nameLabel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 90, heightConstant: 90)
        
        nameLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: cellImage.topAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
    }
}

