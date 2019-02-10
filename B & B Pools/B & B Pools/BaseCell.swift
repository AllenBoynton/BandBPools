//
//  BaseCell.swift
//  B & B Pools
//
//  Created by Allen Boynton on 2/2/19.
//  Copyright © 2019 Allen Boynton. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}
