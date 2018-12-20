//
//  FlashCard.swift
//  FlashCards
//
//  Created by user on 19/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import RealmSwift

class FlashCard: Object {
    @objc dynamic var question: String = ""
    @objc dynamic var answer: String = ""
    var parentCategory = LinkingObjects(fromType: Category.self, property: "flashCards")
}
