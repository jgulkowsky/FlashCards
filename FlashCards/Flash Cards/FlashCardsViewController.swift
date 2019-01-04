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
    func onFlashCardViewRemoved()
}

class FlashCardsViewController: UIViewController {
    
    var category: Category!
    
    private var cardViews = [FlashCardView]()
    private var flashCardToSend: FlashCard? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onInit()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clearDeck()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        FlashCardsRouter.sendParamsToSetFlashCard(self, segue, category, flashCardToSend)
    }
}

extension FlashCardsViewController {
    
    private func onInit() {
        flashCardToSend = nil
        addRightBarButtonItems()
        setTitle()
        addCardsIfPossible()
        showNextCardIfPossible()
    }
    
    private func setTitle() {
        title = category.title
    }
    
    private func addRightBarButtonItems() {
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddCard))
        let reshuffleButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(onReshuffleDeck))
        navigationItem.rightBarButtonItems = [addButtonItem, reshuffleButtonItem]
    }
    
    @objc private func onAddCard() {
        FlashCardsRouter.routeToSetFlashCard(from: self)
    }
    
    @objc private func onReshuffleDeck() {
        clearDeck()
        addCardsIfPossible()
        showNextCardIfPossible()
    }
    
    private func addCardsIfPossible() {
        category.flashCards.forEach { flashCard in
            let flashCardView = FlashCardView()
            view.addSubview(flashCardView)
            flashCardView.initialize(with: flashCard, self, self)
            cardViews.append(flashCardView)
        }
        cardViews.shuffle()
    }
    
    private func showNextCardIfPossible() {
        if !self.cardViews.isEmpty {
            cardViews[0].show()
        }
    }
    
    private func clearDeck() {
        cardViews.forEach { card in
            card.removeFromSuperview()
        }
        cardViews.removeAll()
    }
}

extension FlashCardsViewController: FlashCardViewDelegate {
    
    func onFlashCardViewLongPress(_ flashCardView: FlashCardView, _ flashCard: FlashCard) {
        showAlert(flashCardView, flashCard)
    }
    
    func onFlashCardViewRemoved() {
        removeCardFromDeck()
    }
    
    private func showAlert(_ flashCardView: FlashCardView, _ flashCard: FlashCard) {
        let alert = UIAlertController(title: Names.flashCardsAlertTitle, message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: Names.flashCardsAlertEditTitle, style: .default) { action in
            self.flashCardToSend = flashCard
            FlashCardsRouter.routeToSetFlashCard(from: self)
        })
        
        alert.addAction(UIAlertAction(title: Names.flashCardsAlertDeleteTitle, style: .destructive) { action in
            FlashCardsWorker().deleteFlashCard(flashCard)
            self.removeCardFromDeck()
        })
        
        alert.addAction(UIAlertAction(title: Names.flashCardsAlertCancelTitle, style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    private func removeCardFromDeck() {
        if cardViews.isEmpty {  //this can happen when during swipe animation user decides to go to another screen - deck is cleared on viewWillDisappear and when animation is finished it's empty and there's range out of index exception
            return
        }
        cardViews[0].removeFromSuperview()
        cardViews.remove(at: 0)
        showNextCardIfPossible()
    }
}

extension FlashCardsViewController: Delegate {
    
    func notify(with params: Any?) {
        if let params = params as? (question: String, answer: String) {
            guard let flashCard = (category.flashCards.first { card -> Bool in
                return card.question == params.question && card.answer == params.answer
            }) else {
                fatalError("Cannot get flashCard i DB from SetFlashCardVC response!")
            }
            
            if !cardViews.isEmpty {
                if let flashCardToSend = flashCardToSend {
                    cardViews[0].removeFromSuperview()
                    cardViews.remove(at: 0)
                } else {
                    cardViews[0].hide()
                }
            }
            
            let flashCardView = FlashCardView()
            view.addSubview(flashCardView)
            flashCardView.initialize(with: flashCard, self, self)
            cardViews.insert(flashCardView, at: 0)
            cardViews[0].show()
        }
        
        flashCardToSend = nil
    }
}
