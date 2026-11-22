//
//  StockModel.swift
//  4FebSwiggyDemo
//
//  Created by Shivam Gupta on 04/02/26.
//


import Foundation

struct StockModel: Decodable {
    var success: Bool = false
    var data:[StockDetails]?
}


struct StockDetails: Decodable, Hashable {
    var id = UUID()
    var sid: String?
    var price: Double?
    var change: Double?
}
