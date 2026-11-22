//
//  ConvertorService.swift
//  31Oct
//
//  Created by Shivam Gupta on 01/02/26.
//

import Foundation

protocol ServiceProtocol {
    func getApi<T: Decodable>(url: URL, type: T.Type) async -> Result<T,Error>
}

class ConvertorService: ServiceProtocol {
    func getApi<T: Decodable>(url: URL, type: T.Type) async -> Result<T,Error>  {
        do {
            let (data,_) = try await URLSession.shared.data(for: URLRequest(url: url))
            let decodedData = try JSONDecoder().decode(type, from: data)
            return .success(decodedData)

        }catch (let error) {
            return .failure(error)
        }
    }
}
