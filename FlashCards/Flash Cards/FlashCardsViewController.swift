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
        setBackButtonTitle()
        setTitle()
        addAddButtonItem()
        if !category.flashCards.isEmpty {
            setNoCardsItemsVisibility(to: false)
            addCards()
        }
    }
    
    @IBAction func onNoCardsButtonPressed(_ sender: UIButton) {
        FlashCardsRouter(controller: self, category: category).routeToSetFlashCard()
    }
}

extension FlashCardsViewController {
    
    private func setTitle() {
        title = category.title
    }
    
    private func addAddButtonItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddButtonPressed))
    }
    
    @objc private func onAddButtonPressed() {
        FlashCardsRouter(controller: self, category: category).routeToSetFlashCard()
    }
    
    private func setNoCardsItemsVisibility(to visibile: Bool) {
        noCardsLabel.isHidden = !visibile
        noCardsButton.isHidden = !visibile
    }
    
    private func addCards() {
        category.flashCards.forEach { flashCard in
            let flashCardView = FlashCardView()
            contentView.addSubview(flashCardView)
            flashCardView.initialize(with: flashCard, self)
        }
    }
}

extension FlashCardsViewController: FlashCardViewDelegate {
    
    func onFlashCardViewLongPress(_ flashCardView: FlashCardView, _ flashCard: FlashCard) {
        showAlert(flashCardView, flashCard)
    }
    
    func onFlashCardViewRemoved(_ flashCardView: FlashCardView) {
        flashCardView.removeFromSuperview()
    }
    
    private func showAlert(_ flashCardView: FlashCardView, _ flashCard: FlashCard) {
        let alert = UIAlertController(title: Names.flashCardsAlertTitle, message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: Names.flashCardsAlertEditTitle, style: .default) { action in
            FlashCardsRouter(controller: self, category: self.category, flashCard: flashCard).routeToSetFlashCard()
        })
        
        alert.addAction(UIAlertAction(title: Names.flashCardsAlertDeleteTitle, style: .destructive) { action in
            FlashCardsWorker().deleteFlashCard(flashCard)
            flashCardView.removeFromSuperview()
            
            if self.category.flashCards.isEmpty {
                self.setNoCardsItemsVisibility(to: true)
            }
        })
        
        alert.addAction(UIAlertAction(title: Names.flashCardsAlertCancelTitle, style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
}
