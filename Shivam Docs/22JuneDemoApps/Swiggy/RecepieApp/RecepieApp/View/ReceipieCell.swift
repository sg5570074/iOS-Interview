//
//  ReceipieCell.swift
//  RecepieApp
//
//  Created by Shivam Gupta on 27/02/25.
//

import Foundation
import UIKit

class ReceipieCell: UITableViewCell {



    static let identifier = "ReceipieCell"

    var recepieLbl = UILabel()
    var preparationSteps = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(recepieLbl)
        contentView.addSubview(preparationSteps)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
