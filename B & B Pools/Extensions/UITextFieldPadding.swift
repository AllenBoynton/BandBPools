//
//  TextFieldPadding.swift
//  BandBPools
//
//  Created by Allen Boynton on 9/13/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit

class UITextFieldPadding : UITextField {
    
    let padding = UIEdgeInsetsMake(0, 10, 0, 10)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,
                                     padding)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,
                                     padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,
                                     padding)
    }
}
