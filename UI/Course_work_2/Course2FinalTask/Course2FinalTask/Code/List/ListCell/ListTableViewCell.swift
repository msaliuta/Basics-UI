//
//  ListTableViewCell.swift
//  Course2FinalTask
//
//  Created by Максим Салюта on 10.05.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    
    @IBOutlet weak var cellLabel: UILabel!{
        didSet {
            cellLabel.font = .systemFont(ofSize: 17)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(user: User){
        cellImage.image = user.avatar
        cellLabel.text = user.fullName
    }
}
