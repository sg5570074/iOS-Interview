//
//  FiveViewController.swift
//  FlickerApp
//
//  Created by Shivam Gupta on 23/06/25.
//

import UIKit

class FiveViewController: UIViewController {

    private var viewModel = FiveVM()
    private var collectionView = FlickerCollectionView5()
    private var photos = [FivePhotos]()
    private var seacrhcBAr = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        seacrhcBAr.searchResultsUpdater = self
        navigationItem.searchController = seacrhcBAr
        viewModel.delegeate = self
    }

    func setupCollectionView() {
        collectionView.register(FiveCollectionViewCell.self, forCellWithReuseIdentifier: "FiveCollectionViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
    }


   

}

extension FiveViewController: FiveVMDelegate, UICollectionViewDataSource, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searhcText = searchController.searchBar.text {
            do {
               try viewModel.getPhotosResponse(searhcText)
            } catch (let error) {
                print(error)
            }
        }
    }

    func getPhotosCallback(_ photos: [FivePhotos]) {
        print(";;;;;;\(photos)")
        DispatchQueue.main.async { [weak self] in
            self?.photos = photos
            self?.collectionView.reloadData()
        }
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FiveCollectionViewCell", for: indexPath) as? FiveCollectionViewCell
        cell?.configuureCell(photos[indexPath.row])
        return cell!
    }

}



// OPTIONAL: Collection View subclass with a custom layout
final class FlickerCollectionView5: UICollectionView {
    convenience init() {
        self.init(
            frame: CGRect.zero,
            collectionViewLayout: Self.makeCollectionViewLayout()
        )
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionViewLayout = Self.makeCollectionViewLayout()
    }

    private static func makeCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(0.32)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
       // group.interItemSpacing = .flexible(6)

        let section = NSCollectionLayoutSection(group: group)
      //  section.interGroupSpacing = 6
        return UICollectionViewCompositionalLayout(section: section)
    }
}
