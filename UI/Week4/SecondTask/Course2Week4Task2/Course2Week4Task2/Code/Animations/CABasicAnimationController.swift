//
//  ViewController.swift
//  Course2Week4Task2
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class CABasicAnimationController: UIViewController {
    
    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var cyanView: UIView!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var greenView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        addGesture()
    }

    private func addGesture() {
        orangeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(orangeAnimation(_:))))
        cyanView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cyanAnimation(_:))))
        blueView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(blueAnimation(_:))))
        greenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(greenAnimation(_:))))
    }

    @objc private func orangeAnimation(_ recognizer: UITapGestureRecognizer) {
        let value = orangeView.bounds.width/2
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.cornerRadius))
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.toValue = value
        orangeView.layer.add(animation, forKey: "radius")
        orangeView.layer.cornerRadius = value
    }

    @objc private func cyanAnimation(_ recognizer: UITapGestureRecognizer) {
        let animation = CABasicAnimation(keyPath: "invisibleColor")
        animation.duration = 1
        animation.fromValue = cyanView.layer.backgroundColor
        animation.toValue = nil
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        cyanView.layer.add(animation, forKey: "invisible")
        cyanView.layer.backgroundColor = nil
    }

    @objc private func blueAnimation(_ recognizer: UITapGestureRecognizer) {
        let movement = CABasicAnimation(keyPath: "position")
        let rotate = CABasicAnimation(keyPath: "transform.rotation.z")

        movement.fromValue = blueView.center
        movement.toValue = CGPoint(x: cyanView.center.x, y: blueView.center.y)

        rotate.fromValue = 0
        rotate.toValue = CGFloat(315.0 * .pi / 180.0)


        let group_animation = CAAnimationGroup()
        group_animation.animations = [movement, rotate]
        group_animation.duration = 2
        group_animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        group_animation.isRemovedOnCompletion = false
        blueView.layer.add(group_animation, forKey: "blue")
        blueView.layer.position = CGPoint(x: cyanView.center.x, y: blueView.center.y)

    }

    @objc private func greenAnimation(_ recognizer: UITapGestureRecognizer) {
        let movement_animation = CABasicAnimation(keyPath: "position")
        movement_animation.fromValue = greenView.center
        movement_animation.toValue = view.center

        let color_animation = CABasicAnimation(keyPath: "backgroundColor")
        color_animation.fromValue = UIColor.green.cgColor
        color_animation.toValue = UIColor.magenta.cgColor

        let capacity_animation = CABasicAnimation(keyPath: "transform.scale")
        capacity_animation.toValue = 1.5

        let group_animation = CAAnimationGroup()
        group_animation.animations = [movement_animation, color_animation, capacity_animation]
        group_animation.duration = 2
        group_animation.repeatCount = 2
        group_animation.autoreverses = true
        group_animation.fillMode = .forwards
        group_animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

        greenView.layer.add(group_animation, forKey: nil)
    }
}
