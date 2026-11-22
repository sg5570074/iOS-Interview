//
//  ThirdViewController.swift
//  FlickerApp
//
//  Created by Shivam Gupta on 22/06/25.
//

import UIKit

class ThirdViewController: UIViewController, ThirdDelegate, UICollectionViewDataSource, UISearchResultsUpdating {
    private var seachBAr = UISearchController()
    private var thirdVM = ThirdVM()
    private var collectionView = FlickerCollectionView2()
    private var photos = [ThirdPhotos]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setipCollectionView()
        thirdVM.delegate = self

    }

    func setipCollectionView() {
        collectionView.register(ThirdCellCollectionViewCell.self, forCellWithReuseIdentifier: "ThirdCellCollectionViewCell")
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
        ])

        seachBAr.searchResultsUpdater = self
        navigationItem.searchController = seachBAr
    }


    func getCallBack(_ photos: [ThirdPhotos]) {
       // print(".....\(photos[0])")
        DispatchQueue.main.async { [weak self] in
            self?.photos = photos
            self?.collectionView.reloadData()
        }
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdCellCollectionViewCell", for: indexPath) as! ThirdCellCollectionViewCell
        cell.configureCell(photos[indexPath.row])
        return cell
    }

    func updateSearchResults(for searchController: UISearchController) {
        if (searchController.searchBar.text != nil) {
            do {
               try thirdVM.getPhotosResponse(searchController.searchBar.text!)
            } catch (let error) {
                print(error)
            }
        }
    }


}
