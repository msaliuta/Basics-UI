//
//  ListViewController.swift
//  Course2FinalTask
//
//  Created by Максим Салюта on 10.05.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

enum ShowData {
    case likes
    case followers
    case following
}

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var postId: Post.Identifier!
    var userId: User.Identifier!
    var data: ShowData!
    var cellData: [User]?
    var currentUser: User.Identifier!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch data {
        case .likes:
            title = "Likes"
            cellData = DataProviders.shared.postsDataProvider.usersLikedPost(with: postId)?
                .compactMap { id in
                    return DataProviders.shared.usersDataProvider.user(with: id)
            }
        case .followers:
            title = "Followers"
            cellData = DataProviders.shared.usersDataProvider.usersFollowingUser(with: userId)
        case .following:
            title = "Following"
            cellData = DataProviders.shared.usersDataProvider.usersFollowedByUser(with: userId)
        default:
            break
        }
        
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "\(ListTableViewCell.self)")
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           guard let vc = segue.destination as? ProfileViewController else {
               return
           }

           vc.curUserId = currentUser
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

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let usersLikedThisPost = cellData else {
            return
        }
        
        currentUser = usersLikedThisPost[indexPath.row].id
        performSegue(withIdentifier: "ShowProfile", sender: self)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellData = cellData,
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ListTableViewCell.self)", for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(user: cellData[indexPath.row])
        return cell
    }
    
    
}
