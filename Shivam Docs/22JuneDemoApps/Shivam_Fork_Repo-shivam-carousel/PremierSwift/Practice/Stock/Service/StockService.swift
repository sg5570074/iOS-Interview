//
//  StcokService.swift
//  SwiggyStock
//
//  Created by Shivam Gupta on 02/02/26.
//

import Foundation

protocol StockServiceProtocol {
    func get<T:Decodable>(url: URL, type: T.Type) async -> Result<T,Error>
}

class StockService: StockServiceProtocol {
    func get<T>(url: URL, type: T.Type) async -> Result<T, any Error> where T : Decodable {
        do {
            let (data,_) = try await URLSession.shared.data(for: URLRequest(url: url))
            let decodedData = try JSONDecoder().decode(type, from: data)
            return .success(decodedData)
        } catch (let error) {
            return .failure(error)
        }
    }
}
