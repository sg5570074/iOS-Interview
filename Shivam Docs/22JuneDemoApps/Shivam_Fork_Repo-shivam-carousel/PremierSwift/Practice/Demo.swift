//
//  Demo.swift
//  PremierSwift
//
//  Created by Shivam Gupta on 26/02/25.
//  Copyright © 2025 Deliveroo. All rights reserved.
//

import Foundation
import UIKit

//movie/top_rated

struct Constants {
    static let endPoint = "https://api.themoviedb.org/3/movie/top_rated?api_key=e4f9e61f6ffd66639d33d3dde7e3159b"
}

// MARK: - Api Manager
class DemoApiManager {

    func fetchImages(completion: @escaping (DemoModel)->Void) {
        let request = URLRequest(url: URL(string: Constants.endPoint)!)
        URLSession.shared.dataTask(with: request) { responseData, reponse, error in
            if error == nil {
                do {
                    let result = try JSONDecoder().decode(DemoModel.self, from: responseData!)
                    completion(result)
                } catch let error {
                    print(error)
                }
            }
        }.resume()
    }

}

// MARK: - Model
struct DemoModel: Decodable, Hashable {
    static func == (lhs: DemoModel, rhs: DemoModel) -> Bool {
        return true
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(results)
    }

    var results:[DemoResult]
}

struct DemoResult: Decodable, Hashable {
    var imagePath: String
    var title: String

    enum CodingKeys: String, CodingKey {
        case imagePath = "poster_path"
        case title = "original_title"
    }
}

// MARK: - UIVieWController
class DemoViewController: UIViewController {

    private var tableView: UITableView = {
        return UITableView()
    }()
    var dataModel:[DemoResult]?
    var refreshcontrrol = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Demo APP"
        initilaizeTableView()
        setConstraints()

        DemoApiManager().fetchImages { [weak self] dmeoModel in
            self?.dataModel = dmeoModel.results
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    func initilaizeTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(DemoViewCell.self, forCellReuseIdentifier: "DemoViewCell")
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsMultipleSelection = false
        tableView.allowsSelection = false
        refreshcontrrol.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(refreshcontrrol)

        view.addSubview(tableView)
    }

    @objc func refreshData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.refreshcontrrol.endRefreshing()
        }

    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension DemoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel?.count ?? 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoViewCell", for: indexPath) as? DemoViewCell
        cell?.configureCell(dataModel?[indexPath.row])
        return cell!
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPostion =  scrollView.contentOffset.y
        let scrollHeight = scrollView.contentSize.height
        let tableHeight = tableView.contentSize.height
        print(yPostion)
        print(scrollHeight)
        print(tableHeight)
        if (yPostion + scrollHeight) > tableHeight {
            print("hjbkn")
        }
    }
}

// MARK: - Cell
class DemoViewCell: UITableViewCell {
    var image = Lazyimage()
    var label = UILabel()
    var stackView: UIStackView = {
        let st = UIStackView()
        st.axis = .horizontal
        st.alignment = .leading
        st.spacing = 10
        return st
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(label)
        contentView.addSubview(stackView)
        commonInit()
    }

    private func commonInit() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -10),
            image.widthAnchor.constraint(equalToConstant: 100),
            image.heightAnchor.constraint(equalToConstant: 150)
        ])

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(_ dataModel: DemoResult?) {
        image.setImage(dataModel?.imagePath ?? "")
        label.text = dataModel?.title
    }
}

// MARK: - Image Caching
 class Lazyimage: UIImageView {

    let cacheImage = NSCache<AnyObject, UIImage>()

     func setImage(_ str: String) {
         let imageURL = URL(string: "https://image.tmdb.org/t/p/w185/\(str)")

         if let cachedImage = cacheImage.object(forKey: imageURL as AnyObject) {
             self.image = cachedImage
             return
         }

         //        DispatchQueue.global().async { [weak self] in
         //            let data = try? Data(contentsOf: imageURL!)
         //            if let img = UIImage(data: data!) {
         //                DispatchQueue.main.async {
         //                    self?.cacheImage.setObject(img, forKey: imageURL as AnyObject)
         //                    self?.image = img
         //                }
         //            }
         //
         //        }

         Task {

             let (data, _) = try await URLSession.shared.data(for: URLRequest(url: imageURL!))

             if let image = UIImage(data: data) {
                 self.cacheImage.setObject(image, forKey: imageURL as AnyObject)
                 updateImage(image)
             }

         }
         @MainActor
         func updateImage(_ image: UIImage?) {
             self.image = image
         }

     }

}


// MARK: - Compositional CollectionView

class ComposeViewController: UIViewController {
    var collectionView:UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Int, DemoResult>!
    var dataModel:[DemoResult]?
    override func viewDidLoad() {
        super.viewDidLoad()
        DemoApiManager().fetchImages { [weak self] dmeoModel in
            self?.dataModel = dmeoModel.results
            DispatchQueue.main.async { [weak self] in
                self?.loadData()
            }
        }
        setupCollectionView()
        setupContraints()
        createDataSource()
        loadData()


    }

    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: cretaCompostionalLayout())
        collectionView.register(SimilarMovieCell.self, forCellWithReuseIdentifier: SimilarMovieCell.reuseIdentifier)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
    }

    func setupContraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])

    }
}

extension ComposeViewController {

    func cretaCompostionalLayout() -> UICollectionViewLayout {

        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        return UICollectionViewCompositionalLayout(section: section)
    }

    func createDataSource() {
        dataSource =  UICollectionViewDiffableDataSource<Int, DemoResult>(collectionView: collectionView, cellProvider: { [weak self] collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMovieCell.reuseIdentifier, for: indexPath) as? SimilarMovieCell
            cell?.titleLabel.text = self?.dataModel?[indexPath.row].title
            if let path = self?.dataModel?[indexPath.row].imagePath {
                cell?.coverImage.dm_setImage(posterPath: path)
            }

            return cell
        })
    }

    func loadData() {
        guard let dataModel else { return}
        var snapshot = NSDiffableDataSourceSnapshot<Int,DemoResult>()
        snapshot.appendSections([0])
        snapshot.appendItems(dataModel)
        dataSource.apply(snapshot)
    }
}



class ABC {

   fileprivate func printMyName() {

    }
}

extension ABC {
    func callName() {
        printMyName()
    }
}

class DEF {
    var abc = ABC()
    func callName() {
        abc.printMyName()
    }
}
