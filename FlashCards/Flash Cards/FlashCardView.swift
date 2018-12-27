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
    private var parentViewController: UIViewController!
    private var delegate: FlashCardViewDelegate!
    
    private var isQuestionVisible = true
    
    private var cardLastVelocitiesArray = [CGPoint]()
    private var cardLastVelocitiesArrayIndex = 0
    private var averageCardVelocity = CGPoint(x: 0, y: 0)
    
    func initialize(with flashCard: FlashCard, _ parentViewController: UIViewController, _ delegate: FlashCardViewDelegate) {
        self.flashCard = flashCard
        self.parentViewController = parentViewController
        self.delegate = delegate
        initializeView()
        initializeLabel()
        initializeGestures()
        self.isHidden = true
    }
    
    func show() {
        self.isHidden = false
    }
    
    private func initializeView() {
        self.backgroundColor = UIColor.red
        self.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: getExtraTopOffset() + 10, left: 10, bottom: 10, right: 10))
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
        longPressGesture.require(toFail: panGesture)
        self.addGestureRecognizer(panGesture)
        self.addGestureRecognizer(tapGesture)
        self.addGestureRecognizer(longPressGesture)
    }
    
    @objc private func onPan(_ recognizer: UIPanGestureRecognizer) {
        moveCard()
        rotateCard()
        updateVelocitiesArray()
        if isCardReleased() {
            if shouldCardBeRemoved() {
                updateAverageVelocity()
                moveCardToTheEdgeAndRemove()
            } else {
                moveCardBackToCenter()
            }
        }
    }
    
    @objc private func onTap(_ recognizer: UITapGestureRecognizer) {
        flip()
    }
    
    @objc private func onLongPress(_ recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .ended {
            delegate.onFlashCardViewLongPress(self, flashCard)
        }
    }
    
    private func updateLabel() {
        label.text = isQuestionVisible ? flashCard.question : flashCard.answer
    }
    
    private func getExtraTopOffset() -> CGFloat {
        return UIApplication.shared.statusBarFrame.height + (parentViewController.navigationController?.navigationBar.frame.height ?? 0)
    }
}

//MARK: - Flip Extension
extension FlashCardView {
    
    private func flip() {
        UIView.transition(with: self, duration: 1, options: .transitionFlipFromRight, animations: nil, completion: nil)
        isQuestionVisible = !isQuestionVisible
        updateLabel()
    }
}

//MARK: - Swipe Extension - General Logic, Moving Back, Rotation
extension FlashCardView {
    
    private func moveCard() {
        let translation = panGesture.translation(in: self.superview!)
        self.center.x = self.superview!.center.x + translation.x
        self.center.y = self.superview!.center.y + getExtraTopOffset() / 2 + translation.y
    }
    
    private func rotateCard() {
        let angle = calculateRotationAngle(forDistanceFromCenterX: getDistanceFromCenter().x)
        self.transform = CGAffineTransform.identity.rotated(by: angle)
    }
    
    private func calculateRotationAngle(forDistanceFromCenterX distanceFromCenterX: CGFloat) -> CGFloat {
        let signX = CGFloat(distanceFromCenterX > 0 ? 1 : -1)
        let factor = min(abs(distanceFromCenterX) / AnimationConstants.Swipe.fullAngleRotationDistance, 1)
        let angle = signX * factor * CGFloat(Double.pi)
        return angle
    }
    
    private func updateVelocitiesArray() {
        let maxArraySize = AnimationConstants.Swipe.velocityBuffer
        if cardLastVelocitiesArrayIndex >= maxArraySize {
            cardLastVelocitiesArrayIndex = 0
        }
        let cardVelocity = panGesture.velocity(in: self.superview!)
        let arraySize = cardLastVelocitiesArray.count
        if arraySize > cardLastVelocitiesArrayIndex && arraySize <= maxArraySize {
            cardLastVelocitiesArray[cardLastVelocitiesArrayIndex] = cardVelocity
        } else {
            cardLastVelocitiesArray.append(cardVelocity)
        }
        cardLastVelocitiesArrayIndex += 1
    }
    
    private func isCardReleased() -> Bool {
        return panGesture.state == .ended
    }
    
    private func shouldCardBeRemoved() -> Bool {
        return  abs(getDistanceFromCenter().x) > AnimationConstants.Swipe.noComingBackLinePosX
    }
    
    private func getDistanceFromCenter() -> CGPoint {
        let parentView = self.superview!
        return CGPoint(x: self.center.x - parentView.center.x, y: self.center.y - parentView.center.y + getExtraTopOffset() / 2)
    }
    
    private func moveCardBackToCenter() {
        UIView.animate(
            withDuration: AnimationConstants.Swipe.comeBackDuration,
            delay: 0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0,
            options: UIView.AnimationOptions.curveEaseInOut,
            animations: {
                let center = self.superview!.center
                self.center = CGPoint(x: center.x, y: self.getExtraTopOffset() / 2 + center.y)
                self.transform = CGAffineTransform.identity.rotated(by: 0)
        }, completion: nil)
    }
    
}

//MARK: - Swipe Extension - Removing Card
extension FlashCardView {
    
    private func updateAverageVelocity() {
        calculateAverageVelocity()
        adjustAverageVelocitySignX()
        adjustAverageVelocityWhenSpeedXIsZero()
        adjustAverageVelocityWhenSpeedYIsGreaterThanX()
    }
    
    private func calculateAverageVelocity() {
        var velocitySum = CGPoint(x: 0, y: 0)
        for velocity in cardLastVelocitiesArray {
            velocitySum.x += velocity.x
            velocitySum.y += velocity.y
        }
        let velocityArraySize = CGFloat(cardLastVelocitiesArray.count > 0 ? cardLastVelocitiesArray.count : 1)
        averageCardVelocity = CGPoint(x: velocitySum.x / velocityArraySize, y: velocitySum.y / velocityArraySize)
    }
    
    private func adjustAverageVelocitySignX() {
        //For example when card is over right line of not comming back and user gives velocity to the left and then he releases then averagVelocity.x can be directed towards left edge but we want to change it to the right
        let signX = CGFloat(getDistanceFromCenter().x > 0 ? 1 : -1)
        averageCardVelocity = CGPoint(x: signX * abs(averageCardVelocity.x), y: averageCardVelocity.y)
    }
    
    private func adjustAverageVelocityWhenSpeedXIsZero() {
        let signX = CGFloat(getDistanceFromCenter().x > 0 ? 1 : -1)
        if abs(averageCardVelocity.x) < 0.01 { averageCardVelocity = CGPoint(x: signX, y: 0) }
    }
    
    private func adjustAverageVelocityWhenSpeedYIsGreaterThanX() {
        if abs(averageCardVelocity.y) > abs(averageCardVelocity.x) {
            let signY = CGFloat(averageCardVelocity.y > 0 ? 1 : -1)
            averageCardVelocity.y = signY * abs(averageCardVelocity.x)
        }
    }
    
    private func moveCardToTheEdgeAndRemove() {
        let destination = getFinalCardDestination()
        let edgeDistanceFromCenter = destination.x - self.superview!.center.x
        let rotationAngle = calculateRotationAngle(forDistanceFromCenterX: edgeDistanceFromCenter)
    
        UIView.animate(
            withDuration: AnimationConstants.Swipe.removeDuration,
            delay: 0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0,
            options: getCurveType(),
            animations: {
                self.center = destination
                self.transform = CGAffineTransform.identity.rotated(by: rotationAngle)
        }) { isFinished in
            self.delegate.onFlashCardViewRemoved()
        }
    }
    
    private func getFinalCardDestination() -> CGPoint {
        let parentView = self.superview!
        let initialPoint = self.center
        let signX = CGFloat(getDistanceFromCenter().x > 0 ? 1 : -1)
        let verticalLinePosX = parentView.center.x + signX * (UIScreen.main.bounds.width / 2 + self.frame.width + AnimationConstants.Swipe.removeOffset)
        let velocityLineCoefficient = averageCardVelocity.y / averageCardVelocity.x
        let deltaX = verticalLinePosX - initialPoint.x
        let finalPoint = CGPoint(x: verticalLinePosX, y: initialPoint.y + velocityLineCoefficient * deltaX)
        return finalPoint
    }
    
    private func getCurveType() -> UIView.AnimationOptions {
        let speed = sqrt(averageCardVelocity.x * averageCardVelocity.x + averageCardVelocity.y * averageCardVelocity.y)
        return speed > AnimationConstants.Swipe.removeBorderSpeed ? .curveLinear : .curveEaseInOut
    }
}
