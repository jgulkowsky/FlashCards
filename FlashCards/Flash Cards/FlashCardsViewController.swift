//
//  FlashCardsViewController.swift
//  FlashCards
//
//  Created by user on 18/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class FlashCardsViewController: UIViewController {

    @IBOutlet weak var noCardsLabel: UILabel!
    @IBOutlet weak var noCardsButton: UIButton!
    
    var category: Category!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = category.title
        
        if category.flashCards.isEmpty {
            
        } else {
            noCardsLabel.isHidden = true
            noCardsButton.isHidden = true
            
            category.flashCards.forEach { flashCard in
                print(flashCard)
            }
        }
    }
    
    @IBAction func onNoCardsButtonPressed(_ sender: UIButton) {
        FlashCardsRouter(controller: self, category: category).routeToSetFlashCard()
    }
    
}
