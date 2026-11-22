//
//  StockCell.swift
//  SwiggyStock
//
//  Created by Shivam Gupta on 07/05/25.
//

import UIKit

class StockCell: UITableViewCell {

    static let identifier = "StockCell"

    static func nib() -> UINib {
       return UINib(nibName: "StockCell", bundle: nil)
    }

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func configureCell(_ model: DataModel) {
        lblName.text = model.sid
        lblPrice.text = "\(model.price)"
        lblStatus.text = "\(model.change)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
