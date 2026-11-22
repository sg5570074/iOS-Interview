//
//  FlickrPhotoCell.swift
//  ProcoreRound
//
//  Created by Saikat Das on 18/10/24.
//

import UIKit

//class FlickrPhotoCell: UICollectionViewCell {
//    private let imageView = UIImageView()
//    private let titleLabel = UILabel()
//    private let subTitleLabel = UILabel()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
////
//        contentView.addSubview(imageView)
//        contentView.addAutolayoutView(titleLabel)
//        contentView.addSubview(subTitleLabel)
//    }
//
//    override func layoutSubviews() {
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
//            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16),
//            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16)
//        ])
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func configure(model: Photo) {
//        titleLabel.text = model.title
//        imageView.downloadImage(model.url_t)
//    }
//
//
//
//}

extension UIView {
    func addAutolayoutView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }
}

extension UIImageView {
    func downloadImage(_ url: String) {
        guard let imageURL =  URL(string: url) else { return }
            URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, _ in
                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.image  = image
                }
            }.resume()
    }
}

class FlickrPhotoCell: UICollectionViewCell {

    private let title = UILabel()
    private let subTitle = UILabel()
    private let imageView = UIImageView()
    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        [title, subTitle, imageView].forEach {
            stackView.addArrangedSubview($0)
        }
        contentView.addSubview(stackView)
        setConstriants()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setConstriants() {
        [title, subTitle, imageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
        ])
    }

    func configure(model: Photo) {
            title.text = model.title
            imageView.downloadImage(model.url_t)
        }
}
