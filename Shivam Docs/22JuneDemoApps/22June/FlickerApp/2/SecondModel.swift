//
//  SecondModel.swift
//  FlickerApp
//
//  Created by Shivam Gupta on 22/06/25.
//

import Foundation

struct SecondPhotosResponse: Decodable {
    var photos:SecondResponse
}

struct SecondResponse: Decodable {
    var photo:[SecondPhotos]
}

struct SecondPhotos: Decodable {
    var url_t:String
    var title:String
}
