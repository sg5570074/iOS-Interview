//
//  FiveVM.swift
//  22June
//
//  Created by Shivam Gupta on 23/06/25.
//

import Foundation

protocol FiveVMDelegate: AnyObject {
    func getPhotosCallback(_ photos: [FivePhotos])
}


class FiveVM {
    weak var delegeate:FiveVMDelegate?
    private var apirService = FiveApiService()

    func getPhotosResponse(_ searchText: String) throws {
        if !searchText.isEmpty {

            let finalUrl =  try apirService.buildUrl(searchQuery: searchText)

            URLSession.shared.dataTask(with: finalUrl) { [weak self] data, _, error in
                do {
                   let response = try JSONDecoder().decode(FiveResponse.self, from: data!)
                    self?.delegeate?.getPhotosCallback(response.photos.photo)
                }catch(let error) {
                    print(error)
                }
            }.resume()
        }

    }

}



struct FiveApiService {
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
