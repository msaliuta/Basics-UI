//
//  CAKeyframeAnimationController.swift
//  Course2Week4Task2
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class CAKeyframeAnimationController: UIViewController {
    
    @IBOutlet weak var passcodeTextField: UITextField!
    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var startShakeAnimationButton: UIButton!
    @IBOutlet weak var startSinAnimationButton: UIButton!
    
    @IBAction func shakeAnimationTapHandler(sender: UIButton) {

        let shakeValues = [0, 10, -10, 10, -5, 5, -5, 0]

        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
        translation.timingFunction = CAMediaTimingFunction(name: .linear)
        translation.values = shakeValues
        translation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.8, 1]

        let shakeGroup = CAAnimationGroup()
        shakeGroup.animations = [translation]
        shakeGroup.duration = 0.4
        passcodeTextField.layer.add(shakeGroup, forKey: "shakeIt")
    }

    @IBAction func sinAnimationTapHandler(sender: UIButton) {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = sinPath()
        animation.duration = 6
        animation.repeatCount = .infinity
        animation.rotationMode = .rotateAuto
        orangeView.layer.add(animation, forKey: nil)
    }

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSinPath()
    }
}

extension CAKeyframeAnimationController {
    private func showSinPath() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = sinPath()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        view.layer.addSublayer(shapeLayer)
    }
    
    private func sinPath() -> CGPath {
        let startPoint = orangeView.center
        let width = self.view.bounds.width - 2 * startPoint.x
        let height = self.view.bounds.height / 6.0
        return CGPath.sinPath(startPoint: startPoint, width: width, height: height, periods: 1.5)
    }
}
