//
//  FourthCollectionViewCell.swift
//  FlickerApp
//
//  Created by Shivam Gupta on 22/06/25.
//

import UIKit

class FourthCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lablel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func confogureCell(_ model: ThirdPhotos) {
        lablel.text = model.title
        imageView.getImage(model.url_t)
    }
}
