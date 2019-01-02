//
//  RoundedCornersButton.swift
//  FlashCards
//
//  Created by user on 31/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedCornersButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
