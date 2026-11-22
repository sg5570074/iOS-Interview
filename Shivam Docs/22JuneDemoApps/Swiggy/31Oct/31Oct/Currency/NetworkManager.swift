//
//  NetworkManager.swift
//  31Oct
//
//  Created by Shivam Gupta on 31/10/25.
//

import Foundation


class NetworkManager {
    func getApi<T: Decodable>(_ url: URL, resposnseType:T.Type) async -> Result<T,Error> {
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            print(String(data: data, encoding: .utf8) ?? "No data")
            let decodedData = try JSONDecoder().decode(resposnseType, from: data)
            print(decodedData)
            return .success(decodedData)
        }catch(let error) {
            return .failure(error)
        }
    }
}
