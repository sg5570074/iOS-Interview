//
//  FlickrAPIEndPoint.swift
//  Procore-Coding-Round
//
//  Created by Soham Bhattacharjee on 23/04/25.
//

import Foundation

enum HTTPMethod {
    case GET
}

protocol HTTPProtocol {
    var httpMethod: HTTPMethod { get }
    var urlComponents: URLComponents? { get }
    func buildRequest() -> URLRequest?
}

enum FlickrAPIEndPoint {
    case search(query: String)
}

extension FlickrAPIEndPoint: HTTPProtocol {
    private var baseURL: String {
        "https://api.flickr.com/services/rest"
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .search:
            return .GET
        }
    }
    
    var urlComponents: URLComponents? {
        switch self {
        case .search(let query):
            guard var components = URLComponents(string: baseURL) else {
                return nil
            }
            
            components.queryItems = [
                URLQueryItem(name: "text", value: query),
                URLQueryItem(name: "method", value: "flickr.photos.search"),
                URLQueryItem(name: "api_key", value: "a724969f016f0b8badd7e518a6c48e55"),
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "safe_search", value: "1"),
                URLQueryItem(name: "extras", value: "url_t"),
                URLQueryItem(name: "nojsoncallback", value: "1"),
            ]
            return components
        }
    }
    
    func buildRequest() -> URLRequest? {
        switch self {
        case .search:
            guard let url = urlComponents?.url else {
                return nil
            }
            return URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30.0)
        }
    }
}
