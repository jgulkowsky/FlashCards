//
//  DataModels.swift
//  FlashCards
//
//  Created by user on 19/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

struct DataModels {
    
    struct Category {
        let id: String
        let title: String
        
        init(id: String, title: String) {
            self.id = id
            self.title = title
        }
    }
    
    struct FlashCard {
        let id: String
        let question: String
        let answer: String
        
        init(id: String, question: String, answer: String) {
            self.id = id
            self.question = question
            self.answer = answer
        }
    }
}
