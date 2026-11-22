//
//  FlickerCell.swift
//  FlickerApp
//
//  Created by Shivam Gupta on 22/06/25.
//

import Foundation
import UIKit

class FlickerCell: UICollectionViewCell {
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
