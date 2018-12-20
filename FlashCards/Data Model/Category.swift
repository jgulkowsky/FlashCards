//
//  Category.swift
//  FlashCards
//
//  Created by user on 19/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var title: String = ""
    var flashCards = List<FlashCard>()
}
