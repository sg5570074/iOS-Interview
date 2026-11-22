//
//  SecondVC.swift
//  FlickerApp
//
//  Created by Shivam Gupta on 22/06/25.
//

import UIKit

class SecondVC: UIViewController, secondViewModelDelegate, UICollectionViewDataSource, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text != "" {
            secondVM.callSeondService(searchController.searchBar.text!)
        }
    }
    

    
    private var secondVM = SecondViewModel()
    private var collectionView = FlickerCollectionView2()
    var photos = [SecondPhotos]()
    private var searbar = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        searbar.searchResultsUpdater = self
        navigationItem.searchController = searbar
        secondVM.delegate = self


    }

    func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(SecondCell.self, forCellWithReuseIdentifier: "SecondCell")
        collectionView.dataSource = self
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }

    func giveCallResponse(_ photos: [SecondPhotos]) {
        print("-----\(photos)")
        DispatchQueue.main.async { [weak self] in

            self?.photos = photos
            self?.collectionView.reloadData()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCell", for: indexPath) as! SecondCell
        cell.confirgureCell(photos[indexPath.row])
        return cell
    }
}

// OPTIONAL: Collection View subclass with a custom layout
final class FlickerCollectionView2: UICollectionView {
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




protocol secondViewModelDelegate: AnyObject {
    func giveCallResponse(_ photos: [SecondPhotos])
}

class SecondViewModel {

    weak var delegate:secondViewModelDelegate?
    private var secondService = SecondApiService()

    func callSeondService(_ searchText: String) {
        if !searchText.isEmpty {
            do {
               try secondService.getphotoResponse(searchText) { [weak self] response in

                    self?.delegate?.giveCallResponse(response.photos.photo)
                }
            } catch (let error) {
                print(error)
            }
        }
    }

}
