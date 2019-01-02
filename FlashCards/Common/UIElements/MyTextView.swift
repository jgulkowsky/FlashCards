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
    
    var isInPlaceholderMode = true
    
    func initialize(with delegate: UITextViewDelegate) {
        self.delegate = delegate
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = ColorHelper.uicolorFromHex(0xC8C8CD).cgColor
        self.textContainerInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
    }
    
    func setPlaceholderMode(with placeholder: String) {
        isInPlaceholderMode = true
        self.textColor = ColorHelper.uicolorFromHex(0xC8C8CD)
        self.text = placeholder
    }
    
    func setTextMode(with text: String = "") {
        isInPlaceholderMode = false
        self.textColor = .black
        self.text = text
    }
}
