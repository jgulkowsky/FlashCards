//
//  FlashCardsViewController.swift
//  FlashCards
//
//  Created by user on 18/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

protocol FlashCardViewDelegate {
    
    func onFlashCardViewLongPress(_ flashCard: FlashCard)
    func onFlashCardViewRemoved(_ flashCardView: FlashCardView)
}

class FlashCardsViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
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
                let flashCardView = FlashCardView()
                contentView.addSubview(flashCardView)
                flashCardView.initialize(with: flashCard, self)
            }
        }
    }
    
    @IBAction func onNoCardsButtonPressed(_ sender: UIButton) {
        FlashCardsRouter(controller: self, category: category).routeToSetFlashCard()
    }
}

extension FlashCardsViewController: FlashCardViewDelegate {
    
    func onFlashCardViewLongPress(_ flashCard: FlashCard) {
        FlashCardsRouter(controller: self, category: category, flashCard: flashCard).routeToSetFlashCard()
    }
    
    func onFlashCardViewRemoved(_ flashCardView: FlashCardView) {
        flashCardView.removeFromSuperview()
    }
}
