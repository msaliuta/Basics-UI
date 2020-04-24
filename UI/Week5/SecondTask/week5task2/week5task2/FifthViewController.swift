//
//  FifthViewController.swift
//  week5task2
//
//  Created by Nikolay Zhurba on 23.04.2020.
//  Copyright © 2020 msaliuta. All rights reserved.
//

import UIKit

class FifthViewController: UIViewController {
    // MARK: - Properties

    var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Remove", for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        view.addSubview(backButton)
        setLayout()
    }

    // MARK: - Functions
    private func setLayout() {
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func backButtonPressed (_ sender: UIButton) {
        self.didMove(toParent: self.parent)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }

}
