//
//  ColorHelper.swift
//  FlashCards
//
//  Created by user on 30/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class ColorHelper {
    
    static func uicolorFromHex(_ rgbValue: UInt32) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
}
