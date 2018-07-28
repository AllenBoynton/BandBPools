//
//  BorderedTextViews.swift
//  BandBPools
//
//  Created by Allen Boynton on 7/27/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit

class BorderedTextViews: UITextView {
    
    override func awakeFromNib() {
//        self.layer.cornerRadius = 3.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0).cgColor
        self.clipsToBounds = true
    }
}
