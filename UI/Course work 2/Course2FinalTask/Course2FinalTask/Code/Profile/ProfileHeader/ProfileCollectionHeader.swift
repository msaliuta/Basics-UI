//
//  ProfileCollectionHeader.swift
//  Course2FinalTask
//
//  Created by Максим Салюта on 07.05.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

protocol ProfileCollectionHeaderDelegate: class {
    func showFollowers()
    func showFollowing()
}

class ProfileCollectionHeader: UICollectionReusableView {
    
    @IBOutlet weak var AvatarImage: UIImageView!
    
    @IBOutlet weak var UserNameSurnameLabel: UILabel!
    
    @IBOutlet weak var FollowersLabel: UILabel! {
        didSet {
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(followedLabelTapped))
            FollowersLabel.addGestureRecognizer(recognizer)
        }
    }
    
    @IBOutlet weak var FollowingLabel: UILabel! {
        didSet {
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(followsLabelTapped))
            FollowingLabel.addGestureRecognizer(recognizer)
        }
    }
    
    var delegate: ProfileCollectionHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configure(with user: User){
        AvatarImage.image = user.avatar
        UserNameSurnameLabel.text = user.fullName
        FollowersLabel.text = "Followers: \(user.followedByCount)"
        FollowingLabel.text = "Following: \(user.followsCount)"
    }
    
    @objc private func followedLabelTapped() {
        delegate?.showFollowers()
    }

    @objc private func followsLabelTapped() {
        delegate?.showFollowing()
    }
} 
