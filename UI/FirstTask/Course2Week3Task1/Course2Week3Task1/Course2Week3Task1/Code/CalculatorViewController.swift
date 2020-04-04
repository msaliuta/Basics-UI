//
//  CalculatorViewController.swift
//  Course2Week3Task1
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var firstOperandText: UILabel! {
        didSet {
            firstOperandText.font = .systemFont(ofSize: 17)
            firstOperandText.text = "First operand"
            firstOperandText.sizeToFit()
            firstOperandText.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }

    @IBOutlet weak var resultLabel: UILabel! {
        didSet {
            resultLabel.font = .systemFont(ofSize: 30)
            resultLabel.text = "1"
            resultLabel.textAlignment = .right
            resultLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            resultLabel.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        }
    }

    @IBOutlet weak var firstValueLabel: UILabel!{
        didSet {
            firstValueLabel.font = .systemFont(ofSize: 17)
            firstValueLabel.text = "1.0000"
            firstValueLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            firstValueLabel.sizeToFit()
        }
    }

    @IBOutlet weak var secondOperandText: UILabel!{
        didSet {
            secondOperandText.font = .systemFont(ofSize: 17)
            secondOperandText.text = "Second operand"
            secondOperandText.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            secondOperandText.sizeToFit()
        }
    }

    @IBOutlet weak var secondValueLabel: UILabel! {
        didSet {
            secondValueLabel.font = .systemFont(ofSize: 17)
            secondValueLabel.text = "1.0000"
            secondValueLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            secondValueLabel.sizeToFit()
        }
    }

    @IBOutlet weak var calculateButton: UIButton! {
        didSet {
            calculateButton.setTitle("Calculate", for: .normal)
            calculateButton.backgroundColor = UIColor(red: 236/255, green: 113/255, blue: 73/255, alpha: 1)
            calculateButton.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }

    @IBOutlet weak var firstOperandValueStepper: UIStepper!{
        didSet {
            firstOperandValueStepper.minimumValue = 1
            firstOperandValueStepper.maximumValue = 10
            firstOperandValueStepper.stepValue = 0.5
            firstOperandValueStepper.backgroundColor = UIColor(red: 236 / 255, green: 113 / 255, blue: 73 / 255, alpha: 1)
        }
    }

    @IBOutlet weak var secondOperandValueSlider: UISlider! {
        didSet {
            secondOperandValueSlider.minimumValue = 1
            secondOperandValueSlider.maximumValue = 100
            secondOperandValueSlider.tintColor = UIColor(red: 236/255, green: 113/255, blue: 73/255, alpha: 1)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 45/255, green: 47/255, blue: 49/255, alpha: 1)

        resultLabel.frame = CGRect(x: 16.0, y: 32.0, width: view.bounds.width - 32.0, height: 60.0)
        firstOperandText.frame = CGRect(x: 16.0, y: 124.0, width: view.bounds.width - 32, height: 16.0)
        firstValueLabel.frame.origin = CGPoint(x: 16.0, y: firstOperandText.frame.height + 124 + 16)
        firstOperandValueStepper.center = CGPoint(x: view.bounds.width - 16 - firstOperandValueStepper.frame.width / 2,
                                                  y: firstValueLabel.center.y)
        secondOperandText.frame.origin = CGPoint(x: 16.0,
                                                 y: firstOperandText.frame.height + 172 + firstOperandValueStepper.frame.height)
        secondValueLabel.frame.origin = CGPoint(x: 16.0,
                                                y: firstOperandText.frame.height + 186 + firstOperandValueStepper.frame.height + secondOperandText.frame.height)
        secondOperandValueSlider.frame = CGRect(x: 1, y: 1, width: firstOperandValueStepper.frame.width,
                                                height: firstOperandValueStepper.frame.height)
        secondOperandValueSlider.center = CGPoint(x: view.bounds.width - 16 - secondOperandValueSlider.frame.width / 2,
                                                  y: secondValueLabel.center.y)
        calculateButton.frame = CGRect(x: 16, y: view.bounds.height - 76, width: view.bounds.width - 32, height: 60)
    }

    @IBAction func stepperChangedValue(_ sender: UIStepper) {
        let curValue = Float(sender.value)
        
        firstValueLabel.text = curValue.truncateLeavingFourDigits
        firstValueLabel.sizeToFit()
    }

    @IBAction func sliderChangedValue(_ sender: UISlider) {
        let curValue = Float(sender.value)

        secondValueLabel.text = curValue.truncateLeavingFourDigits
        secondValueLabel.sizeToFit()
    }


    @IBAction func button(_ sender: Any) {
        let first = Float(firstValueLabel.text!)!
        let second = Float(secondValueLabel.text!)!
        resultLabel.text = (first * second).zeroRemover
    }

}

extension Float {

    var truncateLeavingFourDigits:String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        formatter.minimumFractionDigits = 4
        return formatter.string(from: NSNumber(value: self))!
    }

    var zeroRemover:String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        formatter.minimumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self))!
    }
}
