//
//  TextFieldPadding.swift
//  BandBPools
//
//  Created by Allen Boynton on 9/13/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit

class UITextFieldPadding: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
