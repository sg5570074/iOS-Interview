//
//  StockCell.swift
//  PremierSwift
//
//  Created by Shivam Gupta on 03/02/26.
//  Copyright © 2026 Deliveroo. All rights reserved.
//

import UIKit

class StockCell: UITableViewCell {

    private var stackView: UIStackView = {
        let st = UIStackView()
        st.axis = .horizontal
        st.distribution = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        st.spacing = 10
        return st
    }()

    private var stockName = UILabel()
    private var stockPrice = UILabel()
    private var stockChange = UILabel()
    private var favbtton = UIButton()

    var onButtonTap: (() -> Void)?


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    func commonInit() {
        [stockName, stockPrice, stockChange, favbtton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        favbtton.setTitle("Favourite", for: .normal)
        favbtton.setTitleColor(.blue, for: .normal)

        favbtton.addTarget(self, action: #selector(favBtnAction), for: .touchUpInside)
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }

    func configureCell(_ model: StockDetail?) {
        stockName.text = model?.sid
        stockPrice.text = "\(model?.price ?? 0)"
        stockChange.text = "\(model?.change ?? 0)"
    }

    @objc func favBtnAction(){
        onButtonTap?()
        print("pressed")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
