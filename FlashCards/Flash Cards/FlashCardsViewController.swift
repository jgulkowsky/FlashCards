//
//  FlashCardsViewController.swift
//  FlashCards
//
//  Created by user on 18/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

protocol FlashCardViewDelegate {
    
    func onFlashCardViewLongPress(_ flashCardView: FlashCardView, _ flashCard: FlashCard)
    func onFlashCardViewRemoved(_ flashCardView: FlashCardView)
}

class FlashCardsViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var noCardsLabel: UILabel!
    @IBOutlet weak var noCardsButton: UIButton!
    
    var category: Category!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBackButtonTitle("Back")
        
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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddButtonPressed))
    }
    
    @IBAction func onNoCardsButtonPressed(_ sender: UIButton) {
        FlashCardsRouter(controller: self, category: category).routeToSetFlashCard()
    }
    
    @objc private func onAddButtonPressed() {
        FlashCardsRouter(controller: self, category: category).routeToSetFlashCard()
    }
}

extension FlashCardsViewController: FlashCardViewDelegate {
    
    func onFlashCardViewLongPress(_ flashCardView: FlashCardView, _ flashCard: FlashCard) {
        let alert = UIAlertController(title: "What to do?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Edit", style: .default) { action in
            FlashCardsRouter(controller: self, category: self.category, flashCard: flashCard).routeToSetFlashCard()
        })
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { action in
            FlashCardsWorker().deleteFlashCard(flashCard)
            flashCardView.removeFromSuperview()
            
            if self.category.flashCards.isEmpty {
                self.noCardsLabel.isHidden = false
                self.noCardsButton.isHidden = false
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func onFlashCardViewRemoved(_ flashCardView: FlashCardView) {
        flashCardView.removeFromSuperview()
    }
}
