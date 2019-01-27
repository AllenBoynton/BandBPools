//
//  Cells.swift
//  B & B Pools
//
//  Created by Allen Boynton on 10/7/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import LBTAComponents

class UserHeader: DatasourceCell {
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        
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
        }
    }
    
//    let cellImage: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "B&BLogo")
//        imageView.layer.cornerRadius = 5
//        imageView.clipsToBounds = true
//        imageView.materialDesign = true
//        imageView.layer.borderWidth = 2
//        imageView.layer.borderColor = UIColor.darkGray.cgColor
//
//        return imageView
//    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
//    let usernameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "@ABoynton4Mobile"
//        label.textColor = UIColor.rgb(red: 160, green: 160, blue: 160)
//        label.font = UIFont.systemFont(ofSize: 13)
//        return label
//    }()
//
//    let bioTextView: UITextView = {
//        let textView = UITextView()
//        textView.text = "I love the new focus on Augmented reality. Can't wait until I have time to get more into it! https://lnkd.in/eauX8Hi"
//        textView.font = UIFont.systemFont(ofSize: 15)
//        return textView
//    }()
//
//    let followButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Follow", for: UIControl.State())
//        button.setTitleColor(UIColor.rgb(red: 5, green: 159, blue: 245) , for: UIControl.State())
//        button.layer.cornerRadius = 5
//        button.layer.borderColor = UIColor.rgb(red: 5, green: 159, blue: 245).cgColor
//        button.layer.borderWidth = 1
//        return button
//    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        
//        addSubview(cellImage)
        addSubview(nameLabel)
//        addSubview(usernameLabel)
//        addSubview(bioTextView)
//        addSubview(followButton)
        
//        cellImage.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 100)
        
        nameLabel.anchor(nil, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
//        usernameLabel.anchor(nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: bioTextView.topAnchor, right: nameLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
//
//        bioTextView.anchor(usernameLabel.bottomAnchor, left: cellImage.rightAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 0)
//
//        followButton.anchor(self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 120, heightConstant: 34)
    }
}

