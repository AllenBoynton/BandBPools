//
//  BorderedTextViews.swift
//  BandBPools
//
//  Created by Allen Boynton on 7/27/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setPadding() {
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor(red: 67/255, green: 67/255, blue: 67/255, alpha: 1.0).cgColor
        self.clipsToBounds = true
    }
}
