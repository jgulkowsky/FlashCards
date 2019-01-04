//
//  SetFlashCardWorker.swift
//  FlashCards
//
//  Created by user on 20/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import RealmSwift

class SetFlashCardWorker {
    
    private let realm = try! Realm()
    
    func isValid(_ text: String?) -> Bool {
        return text != nil && text! != ""
    }
    
    func addFlashCard(toCategory category: Category, withQuestion question: String, withAnswer answer: String) {
        do {
            try realm.write {
                let flashCard = FlashCard()
                flashCard.question = question
                flashCard.answer = answer
                category.flashCards.append(flashCard)
            }
        } catch {
            print("Error saving flash card \(error)")
        }
    }
    
    func updateFlashCard(_ flashCard: FlashCard, withQuestion question: String, withAnswer answer: String) {
        do {
            try realm.write {
                flashCard.question = question
                flashCard.answer = answer
            }
        } catch {
            print("Error updating flash card \(error)")
        }
    }
}

