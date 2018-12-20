//
//  FlashCardsWorker.swift
//  FlashCards
//
//  Created by user on 20/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import RealmSwift

class FlashCardsWorker {
    
    let realm = try! Realm()
    
    func deleteFlashCard(_ flashCard: FlashCard) {
        do {
            try realm.write {
                realm.delete(flashCard)
            }
        } catch {
            print("Error deleting flash card \(error)")
        }
    }
}
