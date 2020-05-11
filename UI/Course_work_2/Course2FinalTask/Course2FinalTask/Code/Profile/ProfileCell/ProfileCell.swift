//
//  ProfilePostCollectionViewCell.swift
//  Course2FinalTask
//
//  Created by Максим Салюта on 09.05.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class ProfileCell: UICollectionViewCell {
    
    @IBOutlet private var PostImage: UIImageView!
    
    func configure(with post: Post) {
        PostImage.image = post.image
    }
}
