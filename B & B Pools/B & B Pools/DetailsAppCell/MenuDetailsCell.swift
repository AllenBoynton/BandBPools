//
//  MenuDetailsCell.swift
//  B & B Pools
//
//  Created by Allen Boynton on 2/7/19.
//  Copyright © 2019 Allen Boynton. All rights reserved.
//

import UIKit

class MenuDetailsCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
//            collectionView.centerXAnchor.constraint(equalTo: view)
            ])
        
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImageCell
        
        cell.imageView.image = UIImage(named: "Liner Patterns")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: frame.height - 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    private class ImageCell: BaseCell {
        
        let imageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleToFill
            iv.layer.shadowColor = UIColor.black.cgColor
            iv.layer.shadowOffset = CGSize(width: 2, height: 2)
            iv.layer.shadowOpacity = 1
            return iv
        }()
        
        override func setupViews() {
            super.setupViews()
            
            layer.masksToBounds = true
            
            addSubview(imageView)
            
            NSLayoutConstraint.activate([
//                imageView.centerXAnchor.constraint(equalTo: vie)
                ])
        }
    }
}
