//
//  MyTextView.swift
//  FlashCards
//
//  Created by user on 02/01/2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

@IBDesignable
class MyTextView: UITextView {
    
    func initialize(with delegate: UITextViewDelegate) {
        self.delegate = delegate
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = ColorHelper.uicolorFromHex(0xC8C8CD).cgColor
        self.textContainerInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
    }
}
