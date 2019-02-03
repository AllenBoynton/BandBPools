//
//  RGB.swift
//  BandBPools
//
//  Created by Allen Boynton on 7/29/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static var mainBlue = UIColor.rgb(red: 35, green: 79, blue: 145)
}
