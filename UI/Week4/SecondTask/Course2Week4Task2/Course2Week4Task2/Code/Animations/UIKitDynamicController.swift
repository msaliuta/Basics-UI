//
//  UIKitDynamicController.swift
//  Course2Week4Task2
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class UIKitDynamicController: UIViewController {
    
    @IBOutlet weak var anchorView: UIView!
    @IBOutlet weak var animationView: UIView!

    var attachment: UIAttachmentBehavior!
      var animator: UIDynamicAnimator!
      var gravity: UIGravityBehavior!

      override func viewDidLoad() {
          super.viewDidLoad()

          anchorView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.dynamicAnimation(_:))))
      }

      @objc func dynamicAnimation (_ gesture: UIPanGestureRecognizer) {
          attachment = UIAttachmentBehavior(item: animationView, attachedToAnchor: anchorView.center)
          attachment.length = 150

          animator = UIDynamicAnimator(referenceView: view)
          animator.addBehavior(attachment)

          gravity = UIGravityBehavior(items: [animationView])
          animator.addBehavior(gravity)

          attachment.anchorPoint = gesture.location(in: view)
          anchorView.center = attachment.anchorPoint
    }
}
