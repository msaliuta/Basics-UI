//
//  CollectionViewController.swift
//  Course2Week3Task2
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet var collectionViewGallery: UICollectionView!

    var photos: [Photo] = []
    let identifier = String(describing: PhotoCollectionViewCell.self)

    override func viewDidLoad() {
        super.viewDidLoad()

        photos = PhotoProvider().photos()



        let nib = UINib(nibName: identifier, bundle: nil)
        collectionViewGallery.register(nib, forCellWithReuseIdentifier: identifier)

//        collectionViewGallery.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "superCell")
        collectionViewGallery.delegate = self
        collectionViewGallery.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViewGallery.frame = view.frame
    }
}

    // MARK: - Extensions

extension CollectionViewController: UICollectionViewDelegate { }

extension CollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PhotoCollectionViewCell
        collectionCell.configure(with: photos[indexPath.row])
        return collectionCell
    }
}
