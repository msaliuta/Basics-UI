//
//  FeedCell.swift
//  Course2FinalTask
//
//  Created by Nikolay Zhurba on 29.04.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

protocol FeedCellDelegate: class {
    func setUsernameTapp(id: User.Identifier)
    func setAvatarImageTapp(id: User.Identifier)
    func setLikesTapp(id: Post.Identifier)
    func setDoubleImageTapp(id: Post.Identifier)
    func setLikeButtonTapp(id: Post.Identifier)
}

class FeedCell: UITableViewCell {

    @IBOutlet weak var bigLike: UIImageView!{
        didSet {
            bigLike.alpha = 0
        }
    }
    
    @IBOutlet var avatarImage: UIImageView! {
        didSet {
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(setAvatarImageTapped))
            avatarImage.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    @IBOutlet var mainImage: UIImageView! {
        didSet {
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(setDoubleTapp))
            gestureRecognizer.numberOfTapsRequired = 2
            mainImage.addGestureRecognizer(gestureRecognizer)
        }
    }

    @IBOutlet var likesCountLabel: UILabel! {
        didSet {
            likesCountLabel.font = .systemFont(ofSize: 14, weight: .semibold)
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(setLikesTapped))
            likesCountLabel.addGestureRecognizer(gestureRecognizer)
        }
    }
    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = .systemFont(ofSize: 14)
        }
    }
    @IBOutlet var usernameLabel: UILabel! {
        didSet {
            usernameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(setUsernameTapped))
            usernameLabel.addGestureRecognizer(gestureRecognizer)
        }
    }
    @IBOutlet var dateLabel: UILabel! {
        didSet {
            dateLabel.font = .systemFont(ofSize: 14)
        }
    }

    @IBAction func likeButton(_ sender: Any) {
        guard let id = postId else {
            return
        }
        
        delegate?.setLikeButtonTapp(id: id)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }

    var delegate: FeedCellDelegate?
    private var authorId: User.Identifier?
    private var postId: Post.Identifier?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with post: Post) {
        avatarImage.image = post.authorAvatar
        mainImage.image = post.image
        likesCountLabel.text = "Likes: \(post.likedByCount)"
        descriptionLabel.text = post.description
        usernameLabel.text = post.authorUsername

        let date = DateFormatter()
        date.timeStyle  = .medium
        date.dateStyle = .medium

        dateLabel.text = date.string(from: post.createdTime)

        authorId = post.author
        postId = post.id
    }
    
    @objc private func setUsernameTapped() {
        guard let id = authorId else {
            return
        }
        
        delegate?.setUsernameTapp(id: id)
    }
    
    @objc private func setAvatarImageTapped() {
        guard let id = authorId else {
            return
        }
        
        delegate?.setAvatarImageTapp(id: id)
    }
    
    @objc private func setLikesTapped() {
        guard let id = postId else {
            return
        }
        
        delegate?.setLikesTapp(id: id)
    }
    
    @objc private func setDoubleTapp() {
        guard let id = postId else {
            return
        }
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveLinear],
                       animations: { self.bigLike.alpha = 1.0 }, completion: { _ in
                        UIView.animate(withDuration: 0.3, delay: 0.2, options: [.curveEaseOut],
                                       animations: { self.bigLike.alpha = 0.0 }, completion: nil)
        })
        
        delegate?.setDoubleImageTapp(id: id)
    }
}
