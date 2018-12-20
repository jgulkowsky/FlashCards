//
//  FlashCardView.swift
//  FlashCards
//
//  Created by user on 20/12/2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import PureLayout

class FlashCardView: UIView {
    
    private var label: UILabel!
    
    private var tapGesture: UITapGestureRecognizer!
    private var longPressGesture: UILongPressGestureRecognizer!
    private var panGesture: UIPanGestureRecognizer!
    
    private var flashCard: FlashCard!
    private var delegate: FlashCardViewDelegate!
    
    private var isQuestionVisible = true
    
    func initialize(with flashCard: FlashCard, _ delegate: FlashCardViewDelegate) {
        self.flashCard = flashCard
        self.delegate = delegate
        initializeView()
        initializeLabel()
        initializeGestures()
    }
    
    private func initializeView() {
        self.backgroundColor = UIColor.red
        self.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        self.layer.cornerRadius = 20
    }
    
    private func initializeLabel() {
        label = UILabel(frame: CGRect.zero)
        self.addSubview(label)
        label.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        label.textAlignment = .center
        updateLabel()
    }
    
    private func initializeGestures() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPan))
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(onLongPress))
        tapGesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(panGesture)
        self.addGestureRecognizer(tapGesture)
        self.addGestureRecognizer(longPressGesture)
    }
    
    @objc private func onPan(_ recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .ended {
            //TODO: Show animation
            delegate.onFlashCardViewRemoved(self)
        }
    }
    
    @objc private func onTap(_ recognizer: UITapGestureRecognizer) {
        //TODO: Show animation
        isQuestionVisible = !isQuestionVisible
        updateLabel()
    }
    
    @objc private func onLongPress(_ recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .ended {
            //TODO: Show alert -> delete or edit
            delegate.onFlashCardViewLongPress(self, flashCard)
        }
    }
    
    private func updateLabel() {
        label.text = isQuestionVisible ? flashCard.question : flashCard.answer
    }
}
