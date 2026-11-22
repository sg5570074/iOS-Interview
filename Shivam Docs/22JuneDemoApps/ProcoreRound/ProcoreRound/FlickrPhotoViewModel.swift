//
//  FlickrPhotoViewModel.swift
//  ProcoreRound
//
//  Created by Saikat Das on 18/10/24.
//

import Foundation

class FlickrPhotoViewModel {
    var photos: [Photo] = []

    func fetchFlickrAPI(searchString: String) async throws {
        let flickerService = FlickrService()
        let url = try flickerService.buildUrl(searchQuery: searchString)
        let (data, _) = try await URLSession.shared.data(for: url.urlRequest)
        let rep = try JSONSerialization.jsonObject(with: data)
        print(rep)
        let flickrResponse = try JSONDecoder().decode(FlickrResponse.self, from: data)
        photos = flickrResponse.photos.photo
    }
}

struct FlickrService {
    enum FlickrError: Error {
        case path
        case url
    }

    private var path: String { "https://api.flickr.com/services/rest" }

    // Helper method (DO NOT MODIFY)
    func buildUrl(searchQuery: String) throws -> URL {
        guard var components = URLComponents(string: path)
        else { throw FlickrError.path }
        components.queryItems = [
            URLQueryItem(name: "text", value: searchQuery),
            URLQueryItem(name: "method", value: "flickr.photos.search"),
            URLQueryItem(name: "api_key", value: "a724969f016f0b8badd7e518a6c48e55"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "safe_search", value: "1"),
            URLQueryItem(name: "extras", value: "url_t"),
            URLQueryItem(name: "nojsoncallback", value: "1"),
        ]
        guard let url = components.url
        else { throw FlickrError.url }
        return url
    }
}

extension URL {
    var urlRequest: URLRequest {
        URLRequest(url: self)
    }
}
