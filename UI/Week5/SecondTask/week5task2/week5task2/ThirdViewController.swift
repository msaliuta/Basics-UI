//
//  thirdViewController.swift
//  week5task2
//
//  Created by Nikolay Zhurba on 22.04.2020.
//  Copyright © 2020 msaliuta. All rights reserved.
//

import Foundation
import UIKit

class ThirdViewController: UIViewController {

    var text: String?

    @IBOutlet var textLabel: UILabel!

    @IBAction func buttonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toSecondVC", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let reseaveText = text {
            textLabel.text = reseaveText
        }
    }


}
