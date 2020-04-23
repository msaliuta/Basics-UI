//
//  CATransitionController.swift
//  Course2Week4Task2
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class CATransitionController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!

    @IBAction func swipeHandler(_ sender: UISwipeGestureRecognizer) {
        let animation = CATransition()
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.type = .moveIn
        animation.delegate = self

        textLabel.text = "Sliding!"
        textLabel.textColor = .green
        textLabel.layer.add(animation, forKey: "transition")
    }

    private func startFadeAnimation() {
        let animation = CATransition()
        animation.type = .fade
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        textLabel.layer.add(animation, forKey: nil)
        textLabel.textColor = .orange
        textLabel.text = "Initial Text!"
    }
}

extension CATransitionController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        textLabel.layer.removeAnimation(forKey: "transition")
        startFadeAnimation()
    }
}
