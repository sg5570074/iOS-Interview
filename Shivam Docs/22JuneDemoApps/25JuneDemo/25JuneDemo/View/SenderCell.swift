//
//  SenderCell.swift
//  25JuneDemo
//
//  Created by Shivam Gupta on 25/06/25.
//

import UIKit

class SenderCell: UITableViewCell {

    var sendlabl = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
