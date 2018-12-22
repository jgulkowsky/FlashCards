//
//  SetFlashCardQuestionWorker.swift
//  FlashCards
//
//  Created by user on 22/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

class SetFlashCardQuestionWorker {
    
    func isValid(_ title: String?) -> Bool {
        return title != nil && title! != ""
    }
}

