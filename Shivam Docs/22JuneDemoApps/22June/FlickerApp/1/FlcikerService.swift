//
//  FlcikerService.swift
//  FlickerApp
//
//  Created by Shivam Gupta on 21/06/25.
//

import Foundation


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

    func getSeachedItems(_ searchQuery: String, completion: @escaping (FlickrResponse)->Void) throws {

        let url = try buildUrl(searchQuery: searchQuery)

        URLSession.shared.dataTask(with: url) { data, _, error in
            do {
                let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                print(jsonData)
                let flickerData = try JSONDecoder().decode(FlickrResponse.self, from: data!)
                completion(flickerData)
            } catch(let error) {
                print(error)
            }
        }.resume()
    }
}
