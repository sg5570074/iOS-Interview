//
//  SimilarMovieCell.swift
//  PremierSwift
//
//  Created by Shivam Gupta on 11/01/25.
//  Copyright © 2025 Deliveroo. All rights reserved.
//

import UIKit

final class SimilarMovieCell: UICollectionViewCell {
    static let reuseIdentifier = "CarouselCell"

    let columnSpacing: CGFloat = 16
    let posterSize = CGSize(width: 492, height: 134)

    let coverImage = UIImageView()
    let tagView = TagView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let containerStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        titleLabel.font = UIFont.Body.smallSemiBold
        titleLabel.textColor = UIColor.Text.charcoal
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping

        descriptionLabel.font = UIFont.Body.small
        descriptionLabel.textColor = UIColor.Text.grey
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping

        coverImage.contentMode = .scaleAspectFit
        coverImage.layer.cornerRadius = 8
        coverImage.layer.masksToBounds = true

        containerStackView.spacing = 5
        containerStackView.alignment = .top
        containerStackView.axis = .vertical
        containerStackView.translatesAutoresizingMaskIntoConstraints = false

        setupViewsHierarchy()
        setupConstraints()
    }

    func setupViewsHierarchy() {
        contentView.addSubview(containerStackView)
        containerStackView.dm_addArrangedSubviews(coverImage, titleLabel, descriptionLabel, tagView)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            containerStackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),

            coverImage.widthAnchor.constraint(equalToConstant: posterSize.width),
            coverImage.heightAnchor.constraint(equalToConstant: posterSize.height)
        ])
    }

    func configure(_ similarMovie: Movie) {
        titleLabel.text = similarMovie.title
        descriptionLabel.text = similarMovie.overview
        tagView.configure(.rating(value: similarMovie.voteAverage))

        if let path = similarMovie.posterPath {
            coverImage.dm_setImage(posterPath: path)
        } else {
            coverImage.image = nil
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}


final class SimilarMovieCellss: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
