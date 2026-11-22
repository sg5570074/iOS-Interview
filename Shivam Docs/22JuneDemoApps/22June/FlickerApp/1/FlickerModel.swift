//
//  FlickerModel.swift
//  FlickerApp
//
//  Created by Shivam Gupta on 22/06/25.
//

import Foundation

struct FlickrResponse: Decodable {
    let photos: FlickrPhotoResponse
}

struct FlickrPhotoResponse: Decodable {
    let photo: [Photo]
}

struct Photo: Decodable {
    let id: String
    let title: String
    let url_t: String
    let height_t: Int
    let width_t: Int
}
