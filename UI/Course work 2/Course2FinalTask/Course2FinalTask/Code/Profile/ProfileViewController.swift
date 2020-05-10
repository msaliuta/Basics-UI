//
//  ProfileViewController.swift
//  Course2FinalTask
//
//  Created by Максим Салюта on 07.05.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    @IBOutlet weak var cellFlow: UICollectionViewFlowLayout!

    var posts: [Post]?
    var curUserId = DataProviders.shared.usersDataProvider.currentUser().id
    var cellId = String(describing: ProfileCell.self)
    var headerId = "\(ProfileCollectionHeader.self)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = DataProviders.shared.usersDataProvider.user(with: curUserId) else {
            return
        }
        
        posts = DataProviders.shared.postsDataProvider.findPosts(by: curUserId)
        
        cellFlow.minimumLineSpacing = .zero
        cellFlow.minimumInteritemSpacing = .zero
        cellFlow.itemSize = CGSize(width: view.bounds.size.width / 3, height: view.bounds.size.width / 3)
        
        navigationItem.title = user.username
        
        collectionView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        collectionView.register(UINib(nibName: "ProfileCollectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        hidesBottomBarWhenPushed = false
        let vc = segue.destination as! ListViewController
        vc.userId = curUserId
        switch segue.identifier{
        case "ShowFollowers":
            vc.data = .followers
        case "ShowFollowing":
            vc.data = .following
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

extension ProfileViewController: ProfileCollectionHeaderDelegate {
    func showFollowing() {
        print("1")
        performSegue(withIdentifier: "ShowFollowing", sender: self)
    }
    
    func showFollowers() {
        print("2")
        performSegue(withIdentifier: "ShowFollowers", sender: self)
    }    
    
}

extension ProfileViewController: UICollectionViewDelegate {
    
}

extension ProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let posts = posts,
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ProfileCell else {
                return UICollectionViewCell()
        }
        cell.configure(with: posts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let user = DataProviders.shared.usersDataProvider.user(with: curUserId),
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? ProfileCollectionHeader else {
            return UICollectionReusableView()
        }
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 86.0)
        headerView.configure(with: user)
        headerView.delegate = self
        return headerView
    }
    
}
