//
//  ThirdCellCollectionViewCell.swift
//  FlickerApp
//
//  Created by Shivam Gupta on 22/06/25.
//

import UIKit

class ThirdCellCollectionViewCell: UICollectionViewCell {

    private var title = UILabel()
    private var imageView = UIImageView()
    private var stackView = UIStackView()


    override init(frame: CGRect) {
        super.init(frame: frame)
        title.numberOfLines = 2
        [title, imageView, stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        [title, imageView].forEach {
            stackView.addArrangedSubview($0)
        }

        contentView.addSubview(stackView)
        addConstraint()
    }

    func configureCell(_ model: ThirdPhotos) {
        title.text = model.title
        imageView.getImage(model.url_t)
    }

    func addConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImageView {
    func getImage(_ url: String) {
        guard let imageURL = URL(string: url) else { return }

        URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, _ in
            guard let imageData = data, let imageDa = UIImage(data: imageData) else { return }
            DispatchQueue.main.async { [weak self] in
                self?.image = imageDa
            }
        }.resume()

    }
}
