//
//  SecondCell.swift
//  FlickerApp
//
//  Created by Shivam Gupta on 22/06/25.
//

import Foundation
import UIKit

class SecondCell: UICollectionViewCell {

    private var title = UILabel()
    private var imageView = UIImageView()
    private var stackView = UIStackView()
    


    override init(frame: CGRect) {
        super.init(frame: frame)

        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 5
        [stackView, title, imageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        [title, imageView].forEach {
            stackView.addSubview($0)
        }
        contentView.addSubview(stackView)
    }

    func addConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }

    func confirgureCell(_ model:SecondPhotos) {
        title.text = model.title
        imageView.downloadImage(model.url_t)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

