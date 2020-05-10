//
//  FeedClass.swift
//  Course2FinalTask
//
//  Created by Nikolay Zhurba on 28.04.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class FeedViewController: UIViewController {

    var post: [Post] = []
    private var authorId: User.Identifier!
    private var postId: Post.Identifier!

    @IBOutlet var tabelView: UITableView! {
        didSet {
            tabelView.delegate = self
            tabelView.dataSource = self
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()

        post = DataProviders.shared.postsDataProvider.feed()
        tabelView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "posts")
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        hidesBottomBarWhenPushed = false
        switch segue.identifier {
        case "ShowProfile":
            let vc = segue.destination as! ProfileViewController
            vc.curUserId = authorId!
        case "ShowLikes":
            let vc = segue.destination as! ListViewController
            vc.data = .likes
            vc.postId = postId
        default:
            break
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Extensions

extension FeedViewController: UITableViewDelegate {

}

extension FeedViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        post.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feedCell = tableView.dequeueReusableCell(withIdentifier: "posts", for: indexPath) as! FeedCell
        feedCell.configure(with: post[indexPath.row])
        feedCell.delegate = self

        return feedCell
    }
}

extension FeedViewController: FeedCellDelegate {
    func setDoubleImageTapp(id: Post.Identifier) {
        let _ = DataProviders.shared.postsDataProvider.post(with: id)!.currentUserLikesThisPost ? DataProviders.shared.postsDataProvider.unlikePost(with: id) : DataProviders.shared.postsDataProvider.likePost(with: id)
        post = DataProviders.shared.postsDataProvider.feed()
        tabelView.reloadData()
    }
    
    func setLikesTapp(id: Post.Identifier) {
        postId = id
        performSegue(withIdentifier: "ShowLikes", sender: self)
    }
    
    func setAvatarImageTapp(id: User.Identifier) {
        authorId = id
        performSegue(withIdentifier: "ShowProfile", sender: self)
    }
    
    func setUsernameTapp(id: User.Identifier) {
        authorId = id
        performSegue(withIdentifier: "ShowProfile", sender: self)
    }
    
}
