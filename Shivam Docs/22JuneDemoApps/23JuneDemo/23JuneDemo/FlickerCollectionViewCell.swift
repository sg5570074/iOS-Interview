//
//  FlickerCollectionViewCell.swift
//  23JuneDemo
//
//  Created by Shivam Gupta on 23/06/25.
//

import UIKit

class FlickerCollectionViewCell: UICollectionViewCell {

    private var titlelabel = UILabel()
    private var imageView = UIImageView()
    private var subTle = UILabel()
    private var stackView = UIStackView()


    override init(frame: CGRect) {
        super.init(frame: frame)

        [titlelabel, imageView, subTle, stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        [imageView, titlelabel, subTle].forEach {
            stackView.addArrangedSubview($0)
        }

        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }


    func configureCell(_ modle: FlickerPhotos) {
        titlelabel.text = modle.title
        subTle.text = "\(modle.width_t)* \(modle.height_t)"
        imageView.donwloadImage(modle.url_t)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension UIImageView {
    func donwloadImage(_ url: String) {
        guard let imageURL = URL(string: url) else { return }

        URLSession.shared.dataTask(with: imageURL) { [weak self ] data, _, _ in
            guard let imageData = data, let finalImage = UIImage(data: imageData) else { return }

            DispatchQueue.main.async { [weak self] in

                self?.image = finalImage
            }
        }.resume()
    }
}
