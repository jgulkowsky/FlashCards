//
//  DelayedCall.swift
//  FlashCards
//
//  Created by user on 04/01/2019.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

class DelayedCall {
    
    static func call(with delay: Double, _ action: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            action()
        }
    }
}
