//
//  UIViewPropertyAnimatorController.swift
//  Course2Week4Task2
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class UIViewPropertyAnimatorController: UIViewController {

    private var animator: UIViewPropertyAnimator!
    
    @IBOutlet weak var animationView: UIView!
    
    @IBAction func panGestureHandler(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animator = UIViewPropertyAnimator(duration: 5, timingParameters: UISpringTimingParameters(mass: 2.0, stiffness: 30.0, damping: 7.0, initialVelocity: .zero))
            animator.addAnimations {
                self.animationView.center.x += 300
                self.animationView.transform =  self.view.transform.rotated(by: .pi).concatenating(.init(scaleX: 1.5, y: 1.5))
            }
            animator.pauseAnimation()
        case .changed:
            animator.fractionComplete = recognizer.translation(in: view).x/view.bounds.size.height
        case .ended:
            if self.view.center.x > recognizer.translation(in: view).x {
              animator.isReversed = true
            } else {
              animator.isReversed = false
            }
              animator.startAnimation()

        default:
            ()
        }
    }
}
