//
//  TextFieldPadding.swift
//  BandBPools
//
//  Created by Allen Boynton on 9/13/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit

class UITextFieldPadding : UITextField {
    
    let padding = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
