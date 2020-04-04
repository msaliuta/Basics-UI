//
//  TableViewController.swift
//  Course2Week3Task2
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var photos: [Photo] = []


    @IBOutlet var galleryTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        photos = PhotoProvider().photos()

        galleryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")

        galleryTableView.delegate = self
        galleryTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }

    override func viewDidLayoutSubviews() {
        galleryTableView.frame = view.frame
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gallaryCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        gallaryCell.imageView?.image = photos[indexPath.row].image
        gallaryCell.textLabel?.text = photos[indexPath.row].name
        gallaryCell.accessoryType = .detailButton
        return gallaryCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row selected")
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("Accessory selected")
    }
}
