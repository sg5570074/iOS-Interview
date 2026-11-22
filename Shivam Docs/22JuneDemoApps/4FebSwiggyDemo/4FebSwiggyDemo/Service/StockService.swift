//
//  StockService.swift
//  4FebSwiggyDemo
//
//  Created by Shivam Gupta on 04/02/26.
//

import Foundation

enum Generic: Error {
    case decodingError
}

protocol StockServiceProtocol {
    func get<T:Decodable>(url: URL, type:T.Type) async throws -> Result<T, Error>
}

class StockService: StockServiceProtocol {
    func get<T: Decodable>(url: URL, type:T.Type) async throws -> Result<T, Error> {
        do {
            let (data,_) = try await URLSession.shared.data(for: URLRequest(url: url))
            let decodedData = try JSONDecoder().decode(type, from: data)
            return .success(decodedData)
        }catch(let error) {
            return .failure(error)
        }
    }
}
