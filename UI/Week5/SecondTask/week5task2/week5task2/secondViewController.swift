//
//  secondViewController.swift
//  week5task2
//
//  Created by Nikolay Zhurba on 22.04.2020.
//  Copyright © 2020 msaliuta. All rights reserved.
//

import Foundation
import UIKit

class SecondViewCountroller: UIViewController {

    @IBAction func present4VCButton(_ sender: Any) {
        let ViewControll = FourthViewController()
        present(ViewControll, animated: true)
    }

    @IBAction func addChild5VCButtonpressed(_ sender: Any) {
        let ViewControll = FifthViewController()
        view.addSubview(ViewControll.view)
        addChild(ViewControll)
        ViewControll.didMove(toParent: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func unwindToSecondViewController(segue:UIStoryboardSegue) { }
}
