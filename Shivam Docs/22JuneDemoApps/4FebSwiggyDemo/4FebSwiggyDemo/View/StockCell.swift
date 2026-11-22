//
//  StockCell.swift
//  4FebSwiggyDemo
//
//  Created by Shivam Gupta on 04/02/26.
//

import UIKit

class StockCell: UITableViewCell {

    static let cellIdentifier = "StockCell"

    private var stackView: UIStackView = {
        let st = UIStackView()
        st.axis = .horizontal
        st.spacing = 20
        st.distribution = .fillEqually
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()

    private var price = UILabel()
    private var stockName = UILabel()
    private var change = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        [stockName, price, change].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        contentView.addSubview(stackView)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }

    func configureCell(_ model: StockDetails) {
        stockName.text = model.sid ?? ""
        change.text = "Change: \(model.change ?? 0.0)"
        price.text = "Price: \(model.price ?? 0.0)"
    }
}
