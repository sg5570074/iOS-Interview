//
//  SecondApiService.swift
//  FlickerApp
//
//  Created by Shivam Gupta on 22/06/25.
//

import Foundation


struct SecondApiService {
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

    func getphotoResponse(_ searchText: String, completion: @escaping ((SecondPhotosResponse)->Void)) throws {
         let finalUrl = try buildUrl(searchQuery: searchText)

        URLSession.shared.dataTask(with: finalUrl) { data, _, error in
            do {
                let response = try JSONDecoder().decode(SecondPhotosResponse.self, from: data!)
                  completion(response)
            } catch(let error) {
                print(error)
            }

        }.resume()

    }
}
