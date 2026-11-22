//
//  FlickerVM.swift
//  23JuneDemo
//
//  Created by Shivam Gupta on 23/06/25.
//

import Foundation

protocol FlickerDelegate: AnyObject {

    func getCallbaclFlcikerResponse(_ photos: [FlickerPhotos])

}

class FlickerVM {

    weak var delegate: FlickerDelegate?
    private var serviceURL = FlickrService()

    func getFlcikerResponse(_ searchText: String) throws {

        if !searchText.isEmpty {

            let finalURl = try serviceURL.buildUrl(searchQuery: searchText)

            URLSession.shared.dataTask(with: finalURl) { [weak self] data, _, error in
                do {
                    guard let resppnseData = data else { return }
                  let response =  try JSONDecoder().decode(FlickerResponseModel.self, from: resppnseData)
                    self?.delegate?.getCallbaclFlcikerResponse(response.photos.photo)

                }catch(let error) {
                    print(error)
                }
            }.resume()
        }
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
