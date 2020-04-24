//
//  ViewController.swift
//  week5task2
//
//  Created by Nikolay Zhurba on 22.04.2020.
//  Copyright © 2020 msaliuta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var vcTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func toThirdVC(_ sender: Any) {
        performSegue(withIdentifier: "toThirdVC", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ThirdViewController {
            if let textToPass = vcTextField.text {
                destination.text = textToPass
            }
        }
    }
}
