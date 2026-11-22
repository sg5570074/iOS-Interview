//
//  ViewController.swift
//  FlickerApp
//
//  Created by Shivam Gupta on 21/06/25.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {

    
    private var viewModel = FlickerViewModel()

    private var collectionView = FlickerCollectionView()
    private var searchBar = UISearchController()
    var photos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupCollectionView()
        viewModel.delegate = self
    }

    func setupSearchBar() {
        searchBar.searchResultsUpdater = self
        searchBar.searchBar.delegate = self
        navigationItem.searchController = searchBar
    }


    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.backgroundColor = .blue
        collectionView.register(FlickerCell.self, forCellWithReuseIdentifier: "FlickerCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }

    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text != "" {

            guard let text = searchController.searchBar.text else { return }
            print(text)
            viewModel.getSearchText(text)
        }
    }


}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlickerCell", for: indexPath) as! FlickerCell
        cell.configure(model: photos[indexPath.row])
        return cell
    }
    

}

extension ViewController: FlickerViewModelDelegate {
    func giveCallBackResponse(_ photos: [Photo]) {
        DispatchQueue.main.async { [weak self] in
            self?.photos = photos
            self?.collectionView.reloadData()
        }

    }

}

// OPTIONAL: Collection View subclass with a custom layout
final class FlickerCollectionView: UICollectionView {
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
