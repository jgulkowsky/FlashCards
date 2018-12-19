//
//  FlashCardsViewController.swift
//  FlashCards
//
//  Created by user on 18/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

protocol FlashCardsGetWorkerDelegate {
    func getFlashCards(_ flashCards: [DataModels.FlashCard])
}

class FlashCardsViewController: UIViewController {

    var category: DataModels.Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = category.title
    }
}
