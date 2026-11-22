//
//  RecepieCell.swift
//  RecepieApp
//
//  Created by Shivam Gupta on 06/05/25.
//

import UIKit

class RecepieCell: UITableViewCell {

    @IBOutlet private weak var recepieLbl: UILabel!
    @IBOutlet private weak var ingredientLbl: UILabel!

    var recepieData: Recepie?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell() {
        recepieLbl.text = recepieData?.name
        ingredientLbl.text = recepieData?.ingredient.joined(separator: ",")

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
