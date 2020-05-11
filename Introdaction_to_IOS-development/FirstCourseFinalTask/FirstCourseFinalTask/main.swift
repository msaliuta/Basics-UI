//
//  main.swift
//  FirstCourseFinalTask
//
//  Copyright © 2017 E-Legion. All rights reserved.
//

import Foundation
import FirstCourseFinalTaskChecker

class User: UserProtocol {

    init(id: UserProtocol.Identifier, username: String, fullName: String, avatarURL: URL?, currentUserFollowsThisUser: Bool, currentUserIsFollowedByThisUser: Bool, followsCount: Int, followedByCount: Int){
        self.id = id
        self.username = username
        self.fullName = fullName
        self.avatarURL = avatarURL
        self.currentUserFollowsThisUser = currentUserFollowsThisUser
        self.currentUserIsFollowedByThisUser = currentUserIsFollowedByThisUser
        self.followsCount = followsCount
        self.followedByCount = followedByCount
    }

    var id: User.Identifier

    var username: String

    var fullName: String

    var avatarURL: URL?

    var currentUserFollowsThisUser: Bool

    var currentUserIsFollowedByThisUser: Bool

    var followsCount: Int

    var followedByCount: Int

}

class UsersStorageClass: UsersStorageProtocol {

    var user: [User]
    var follower: [ (GenericIdentifier<UserProtocol>, GenericIdentifier<UserProtocol>)]
    var curUserId: GenericIdentifier<UserProtocol>

    required init?(users: [UserInitialData], followers: [(GenericIdentifier<UserProtocol>, GenericIdentifier<UserProtocol>)], currentUserID: GenericIdentifier<UserProtocol>) {

        guard users.contains(where: { $0.id == currentUserID}) else {
            return nil
        }
        user = users.map{ user in
            return User(id: user.id, username: user.username, fullName: user.fullName, avatarURL: user.avatarURL, currentUserFollowsThisUser: followers.contains(where: { $0.0 == currentUserID && $0.1 == user.id
            }), currentUserIsFollowedByThisUser: followers.contains(where: { $0.0 == user.id && $0.1 == currentUserID
            }), followsCount: followers.filter{
                $0.0 == user.id
            }.count,
                followedByCount: followers.filter{
                    $0.1 == user.id
                }.count)
        }
        follower = followers
        curUserId = currentUserID

    }

    var count: Int { get {
        return user.count
        }
    }

    func currentUser() -> UserProtocol {
        return user(with: curUserId)!
    }

    func user(with userID: GenericIdentifier<UserProtocol>) -> UserProtocol? {
        return  user.first(where: {$0.id == userID})
    }

    func findUsers(by searchString: String) -> [UserProtocol] {
        return user.filter{
            $0.fullName == searchString || $0.username == searchString
        }
    }

    func follow(_ userIDToFollow: GenericIdentifier<UserProtocol>) -> Bool {
        guard user.contains(where: {$0.id == userIDToFollow}) else {
            return false
        }
        guard !follower.contains(where: {$0.0 == curUserId && $0.1 == userIDToFollow}) else {
            return true
        }
        follower.append((curUserId, userIDToFollow))
        let curuser = user(with: curUserId) as! User
        curuser.followsCount += 1
        let usertofollow = user(with: userIDToFollow) as! User
        usertofollow.followedByCount += 1
        return true
    }

    func unfollow(_ userIDToUnfollow: GenericIdentifier<UserProtocol>) -> Bool {
        guard user.contains(where: {$0.id == userIDToUnfollow})  else {
            return false
        }
        follower = follower.filter{ $0 != (curUserId, userIDToUnfollow) }
        let curuser = user(with: curUserId) as! User
        curuser.followsCount -= 1
        let usertofollow = user(with: userIDToUnfollow) as! User
        usertofollow.followedByCount -= 1
        return true
    }

    func usersFollowingUser(with userID: GenericIdentifier<UserProtocol>) -> [UserProtocol]? {
        guard user.contains(where: {$0.id == userID})  else {
            return nil
        }

        let followers = follower.filter{ $0.1 == userID }.compactMap{ tmp in
            return user(with: tmp.0)
        }
        return followers
    }

    func usersFollowedByUser(with userID: GenericIdentifier<UserProtocol>) -> [UserProtocol]? {
        guard user.contains(where: {$0.id == userID})  else {
            return nil
        }

        let followed = follower.filter{ $0.0 == userID }.compactMap{ tmp in
            return user(with: tmp.1)
        }
        return followed
    }


}


class Post: PostProtocol {

    init(id: PostProtocol.Identifier, author: GenericIdentifier<UserProtocol>, description: String, imageURL: URL, createdTime: Date, currentUserLikesThisPost: Bool, likedByCount: Int){
        self.id = id
        self.author = author
        self.description = description
        self.imageURL = imageURL
        self.createdTime = createdTime
        self.currentUserLikesThisPost = currentUserLikesThisPost
        self.likedByCount = likedByCount
    }

    var id: Post.Identifier

    var author: GenericIdentifier<UserProtocol>

    var description: String

    var imageURL: URL

    var createdTime: Date

    var currentUserLikesThisPost: Bool

    var likedByCount: Int

}

class PostsStorageClass: PostsStorageProtocol {

    var post: [Post] = []
    var like: [(GenericIdentifier<UserProtocol>, GenericIdentifier<PostProtocol>)] = []
    var curUserId: GenericIdentifier<UserProtocol>

    required init(posts: [PostInitialData], likes: [(GenericIdentifier<UserProtocol>, GenericIdentifier<PostProtocol>)], currentUserID: GenericIdentifier<UserProtocol>) {
        like = likes
        curUserId = currentUserID
        post = posts.map{ post in
            return Post(id: post.id, author: post.author, description: post.description, imageURL: post.imageURL, createdTime: post.createdTime, currentUserLikesThisPost: like.contains(where: {$0.0 == currentUserID && $0.1 == post.id}), likedByCount: like.filter({ $0.1 == post.id }).count)
        }
    }

    var count: Int { get {
        return post.count
        }
    }

    func post(with postID: GenericIdentifier<PostProtocol>) -> PostProtocol? {
        return post.first(where: { $0.id == postID})
    }

    func findPosts(by authorID: GenericIdentifier<UserProtocol>) -> [PostProtocol] {
        return post.filter{ $0.author == authorID }
    }

    func findPosts(by searchString: String) -> [PostProtocol] {
        return post.filter({$0.author.rawValue == searchString || $0.description == searchString})
    }

    func likePost(with postID: GenericIdentifier<PostProtocol>) -> Bool {
        guard post.contains(where: {$0.id == postID}) else {
            return false
        }

        guard !like.contains(where: {$0.0 == curUserId && $0.1 == postID}) else {
            return true
        }


        like.append((curUserId, postID))
        let tmp = post(with: postID) as! Post
        tmp.currentUserLikesThisPost = true
        return true
    }

    func unlikePost(with postID: GenericIdentifier<PostProtocol>) -> Bool {
        guard post.contains(where: {$0.id == postID}) else {
            return false
        }
        like = like.filter{ $0 != (curUserId, postID) }
        let tmp = post(with: postID) as! Post
        tmp.currentUserLikesThisPost = false
        return true
    }

    func usersLikedPost(with postID: GenericIdentifier<PostProtocol>) -> [GenericIdentifier<UserProtocol>]? {
        guard post.contains(where: { $0.id == postID }) else {
            return nil
        }

        let users = like.filter{ $0.1 == postID }.map{ tuple in
            return tuple.0
        }
        return users
    }

}

//let first: UsersStorageClass()
//let second: PostsStorageClass()

let checker = Checker(usersStorageClass: UsersStorageClass.self,
                      postsStorageClass: PostsStorageClass.self)
checker.run()

