//
//  DesignableButtons.swift
//  About Me
//
//  Created by Allen Boynton on 8/7/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit

// Creates rounded buttons for choice buttons
@IBDesignable class DesignableButtons: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var masksToBounds: Bool = false {
        didSet {
            self.layer.masksToBounds = masksToBounds
        }
    }
}
