//
//  ApiManager.swift
//  POPDemo
//
//  Created by Shivam Gupta on 25/11/25.
//

import Foundation

protocol ApiManagerProtocol {
    func getApi<T:Decodable>(_ url:URL, type: T.Type) async -> Result<T,Error>
}


class ApiManager: ApiManagerProtocol {

    func getApi<T:Decodable>(_ url:URL, type: T.Type) async -> Result<T,Error> {
        let request = URLRequest(url: url)
        do {
            let (data,_) = try await URLSession.shared.data(for: request)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        }catch (let error) {
            return .failure(error)
        }
    }
}


// We can create factory and return our URL
enum Enviromnent {
    case teflon
    case Prod
}
