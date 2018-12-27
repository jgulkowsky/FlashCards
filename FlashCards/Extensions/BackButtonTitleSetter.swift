//
//  BackButtonTitleSetter.swift
//  FlashCards
//
//  Created by user on 22/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setBackButtonTitle(_ title: String = Names.backButtonText) {
        let backItem = UIBarButtonItem()
        backItem.title = title
        navigationItem.backBarButtonItem = backItem
    }
}
