//
//  RadioViewController.swift
//  Course2Week4Task1
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class RadioViewController: UIViewController {

    private var logoImageView: UIImageView = {
        let photo = UIImageView()
        photo.image = UIImage(named: "logo")
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.contentMode = UIImageView.ContentMode.scaleAspectFill
        photo.clipsToBounds = true
        return photo
    }()

    private var musicProgressView: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.progress = 0.5
        return progress
    }()

    private var musicSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.value = 0.5
        return slider
    }()

    private var groupNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = -1
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 22)
        label.text = "Aerosmith - Hole in my Soul"
        return label
    }()

    lazy var portret: [NSLayoutConstraint] = [
        musicProgressView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30.0),
        musicProgressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
        musicProgressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
        
        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8.0),
        logoImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
        logoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
        logoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0.0),
        logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 1),
        
        musicSlider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24.0),
        musicSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
        musicSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
        musicSlider.heightAnchor.constraint(equalToConstant: 32.0),
        
        layoutGuide.topAnchor.constraint(equalTo: musicProgressView.bottomAnchor),
        layoutGuide.bottomAnchor.constraint(equalTo: musicSlider.topAnchor),
        
        groupNameLabel.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor),
        groupNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
        groupNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0)]
    
    lazy var landscape: [NSLayoutConstraint] = [
        musicProgressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
        musicProgressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        musicProgressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        musicProgressView.heightAnchor.constraint(equalToConstant: 2),
        
        logoImageView.topAnchor.constraint(equalTo: musicProgressView.bottomAnchor, constant: 16.0),
        logoImageView.bottomAnchor.constraint(equalTo: musicSlider.topAnchor, constant: -16),
        logoImageView.trailingAnchor.constraint(equalTo: groupNameLabel.leadingAnchor, constant: 16),
        logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: 1),
        logoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        
        layoutGuide.topAnchor.constraint(equalTo: musicProgressView.bottomAnchor),
        layoutGuide.bottomAnchor.constraint(equalTo: musicSlider.topAnchor),
        
        groupNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        groupNameLabel.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor),
        
        musicSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        musicSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        musicSlider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
        musicSlider.heightAnchor.constraint(equalToConstant: 31)]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(musicSlider)
        view.addSubview(logoImageView)
        view.addSubview(musicProgressView)
        view.addSubview(groupNameLabel)
        view.addLayoutGuide(layoutGuide)

        constraintConfigure()

    }

    let layoutGuide = UILayoutGuide()

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        super.traitCollectionDidChange(previousTraitCollection)

        constraintConfigure()
    }

    private func constraintConfigure() {
        if view.traitCollection.verticalSizeClass == .regular {
            NSLayoutConstraint.deactivate(landscape)
            NSLayoutConstraint.activate(portret)
        } else {
            NSLayoutConstraint.deactivate(portret)
            NSLayoutConstraint.activate(landscape)
        }
    }
    
}
