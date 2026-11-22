//
//  FiveModel.swift
//  22June
//
//  Created by Shivam Gupta on 23/06/25.
//


struct FiveResponse: Decodable {
    let photos: FivePhotosResponse
}

struct FivePhotosResponse: Decodable {
    let photo: [FivePhotos]
}

struct FivePhotos: Decodable {
    let title: String
    let url_t: String
}
