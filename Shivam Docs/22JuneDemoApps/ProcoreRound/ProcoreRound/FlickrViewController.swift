//
//  ViewController.swift
//  ProcoreRound
//
//  Created by Saikat Das on 18/10/24.
//

import UIKit

final class FlickrViewController: UIViewController {
    private var searchController: UISearchController?
    private var flickerViewCollection: UICollectionView?
    static let cellID = String(describing: FlickrPhotoCell.self)
    let viewModel = FlickrPhotoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItem()
        addSearchBar()
        addCollectionView()
        searchController?.searchBar.delegate = self
        flickerViewCollection?.dataSource = self
    }

}

extension FlickrViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { return }

        Task {
            try await viewModel.fetchFlickrAPI(searchString: searchText)
            flickerViewCollection?.reloadData()
        }

    }
}

extension FlickrViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Self.cellID,
            for: indexPath
        ) as! FlickrPhotoCell
        let model = viewModel.photos[indexPath.row]
        cell.configure(model: model)
        return cell
    }
}



// Convenience methods to setup your view
private extension FlickrViewController {
    func configureNavigationItem() {
        navigationItem.title = NSLocalizedString("Flickr Challenge", comment: "main grid title")
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    func addSearchBar() {
        self.searchController = makeSearchController()
        navigationItem.searchController = searchController
    }

    func makeSearchController() -> UISearchController {
        let searchController = UISearchController()
        searchController.searchBar.showsSearchResultsButton = false
        searchController.searchBar.returnKeyType = .done
        searchController.searchBar.showsCancelButton = false
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
    }

    func addCollectionView() {
        let collectionView = FlickerCollectionView()
        self.flickerViewCollection = collectionView

        // when cells was programatically created
        collectionView.register(FlickrPhotoCell.self, forCellWithReuseIdentifier: Self.cellID)
        // when cell was created via a NIB
        //collectionView.register(UINib(nibName: "FlickrPhotoCell", bundle: nil), ....)

        view.addAutolayoutView(collectionView)
        collectionView.backgroundColor = .systemPink

        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: collectionView.topAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor)
        ])
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

