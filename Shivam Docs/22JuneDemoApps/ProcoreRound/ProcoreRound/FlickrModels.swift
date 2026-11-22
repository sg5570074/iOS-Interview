//
//  FlickrModels.swift
//  ProcoreRound
//
//  Created by Saikat Das on 18/10/24.
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
