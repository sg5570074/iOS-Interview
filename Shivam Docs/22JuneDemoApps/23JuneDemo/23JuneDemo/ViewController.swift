//
//  ViewController.swift
//  23JuneDemo
//
//  Created by Shivam Gupta on 23/06/25.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating {

    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            do {
               try viewModel.getFlcikerResponse(searchText)
            }catch(let error) {
                print(error)
            }
        }
    }






    var viewModel = FlickerVM()
    var collectionView = FlickerCollectionView()
    private var photos = [FlickerPhotos]()
    private var searchBAr = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBAr.searchResultsUpdater = self
        navigationItem.searchController = searchBAr
        setupCollectionView()
        viewModel.delegate = self


    }

    func setupCollectionView() {
        collectionView.register(FlickerCollectionViewCell.self, forCellWithReuseIdentifier: "FlickerCollectionViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        view.addSubview(collectionView)

       // NSLayoutConstraint.activate(<#T##constraints: [NSLayoutConstraint]##[NSLayoutConstraint]#>)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
    }


}


extension ViewController: FlickerDelegate, UICollectionViewDataSource {
    func getCallbaclFlcikerResponse(_ photos: [FlickerPhotos]) {
        print("--------\(photos)")
        DispatchQueue.main.async { [weak self] in
            self?.photos = photos
            self?.collectionView.reloadData()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "FlickerCollectionViewCell", for: indexPath) as! FlickerCollectionViewCell
        cell.configureCell(photos[indexPath.row])
        return cell
    }
}







//final class FlickrViewController: UIViewController {
//    private var searchController: UISearchController?
//    private var flickerViewCollection: UICollectionView?
//    static let cellID = String(describing: FlickrPhotoCell.self)
//}
//
//// Convenience methods to setup your view
//private extension FlickrViewController {
//    func configureNavigationItem() {
//        navigationItem.title = NSLocalizedString("Flickr Challenge", comment: "main grid title")
//        navigationItem.hidesSearchBarWhenScrolling = false
//    }
//
//    func addSearchBar() {
//        self.searchController = makeSearchController()
//        navigationItem.searchController = searchController
//    }
//
//    func makeSearchController() -> UISearchController {
//        let searchController = UISearchController()
//        searchController.searchBar.showsSearchResultsButton = false
//        searchController.searchBar.returnKeyType = .done
//        searchController.searchBar.showsCancelButton = false
//        searchController.hidesNavigationBarDuringPresentation = false
//        return searchController
//    }
//
//    func addCollectionView() {
//        let collectionView = FlickerCollectionView()
//        self.flickerViewCollection = collectionView
//
//        // when cells was programatically created
//        collectionView.register(FlickrPhotoCell.self, forCellWithReuseIdentifier: Self.cellID)
//        // when cell was created via a NIB
//        //collectionView.register(UINib(nibName: "FlickrPhotoCell", bundle: nil), ....)
//
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(collectionView)
//
//        NSLayoutConstraint.activate([
//            view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: collectionView.topAnchor),
//            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
//            view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
//            view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor)
//        ])
//    }
//}

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
            widthDimension: .fractionalWidth(0.32),
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
        group.interItemSpacing = .flexible(6)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 6
        return UICollectionViewCompositionalLayout(section: section)
    }
}
