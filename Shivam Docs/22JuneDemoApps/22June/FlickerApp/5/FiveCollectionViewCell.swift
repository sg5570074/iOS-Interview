//
//  FiveCollectionViewCell.swift
//  FlickerApp
//
//  Created by Shivam Gupta on 23/06/25.
//

import UIKit

class FiveCollectionViewCell: UICollectionViewCell {

    private var label = UILabel()
    private var imageView = UIImageView()
    private var stackView = UIStackView()


    override init(frame: CGRect) {
        super.init(frame: frame)
        [label, imageView, stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        [stackView].forEach {
            $0.axis = .vertical
            $0.spacing = 20
            $0.alignment = .center
        }

        [label, imageView].forEach {
            stackView.addArrangedSubview($0)
        }
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func configuureCell(_ model: FivePhotos) {
        label.text = model.title
        imageView.getImage(model.url_t)
    }

}
