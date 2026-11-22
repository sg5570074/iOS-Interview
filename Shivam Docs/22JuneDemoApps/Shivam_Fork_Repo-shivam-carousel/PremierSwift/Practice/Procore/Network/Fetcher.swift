//
//  Fetcher.swift
//  Procore-Coding-Round
//
//  Created by Soham Bhattacharjee on 23/04/25.
//

import Foundation

enum FlickrError: Error {
    case badRequest
    case noDataFound
    case error(Error)
}

struct Fetcher {
    func search(_ query: String) async -> Result<[Photo], FlickrError> {
        guard let urlRequest = FlickrAPIEndPoint.search(query: query).buildRequest() else {
            return .failure(.badRequest)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let flickrData = try JSONDecoder().decode(FlickrData.self, from: data)
            if let photos = flickrData.photos?.photo {
                return .success(photos)
            }
            return .failure(.noDataFound)
        } catch {
            return .failure(.error(error))
        }
    }
}
