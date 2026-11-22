//
//  NewsSourceCell.swift
//  POPDemo
//
//  Created by Shivam Gupta on 25/11/25.
//

import UIKit

class NewsSourceCell: UITableViewCell {

    private var containerView: UIStackView = {
        let stk = UIStackView()
        stk.axis = .vertical
        stk.spacing = 10
        return stk
    }()

    private var image = Lazyimage()
    private var titile = UILabel()
    private var name = UILabel()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [image, titile, name].forEach {

            containerView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)


        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

    func configureCell(model: NewsSourceModel) {
        image.image = UIImage()
        titile.text = model.description
        name.text = model.name
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
