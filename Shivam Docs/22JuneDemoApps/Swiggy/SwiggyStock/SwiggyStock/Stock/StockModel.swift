//
//  StcokModel.swift
//  SwiggyStock
//
//  Created by Shivam Gupta on 02/02/26.
//

import Foundation

struct Stock1Model: Decodable {
    var success: Bool
    var data: [StockDetail]
}

struct StockDetail: Decodable {
    var sid: String?
    var price: Decimal?
    var change: Decimal?
}
