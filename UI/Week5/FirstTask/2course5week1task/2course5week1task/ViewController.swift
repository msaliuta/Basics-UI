//
//  ViewController.swift
//  2course5week1task
//
//  Created by Maksym Saliuta on 17.04.2020.
//  Copyright © 2020 msaliuta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet var launchLabel: UILabel!
    @IBOutlet var appearanseView: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let date = Date()
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.timeStyle = .medium
        dateFormatterGet.dateStyle = .medium
        launchLabel.text = dateFormatterGet.string(from: date)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateAppearanseView()
    }

    @IBAction func updateButton(_ sender: Any) {
        updateAppearanseView()
    }

    private func updateAppearanseView(){
        let date = Date()
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.timeStyle = .medium
        dateFormatterGet.dateStyle = .medium
        appearanseView.text = dateFormatterGet.string(from: date)
    }
}

