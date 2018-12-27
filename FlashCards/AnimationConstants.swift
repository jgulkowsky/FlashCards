//
//  Constants.swift
//  FlashCards
//
//  Created by user on 27/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

struct AnimationConstants {

    struct Flip {
        static let duration = 0.3
    }
    
    struct Swipe {
        static let comeBackDuration = 0.5
        static let removeDuration = 1.0
        static let noComingBackLinePosX = UIScreen.main.bounds.width / 4
        static let removeOffset = UIScreen.main.bounds.width / 3
        static let removeBorderSpeed: CGFloat = 1
        static let velocityBuffer = 2
        static let fullAngleRotationDistance = 8 * UIScreen.main.bounds.width
    }
}
