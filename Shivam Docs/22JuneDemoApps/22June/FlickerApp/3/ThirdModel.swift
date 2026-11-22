//
//  ThirdModel.swift
//  FlickerApp
//
//  Created by Shivam Gupta on 22/06/25.
//

import Foundation

struct ThirdResponse:Decodable {
    var photos:ThirdPhotoResponse
}

struct ThirdPhotoResponse:Decodable {
    var photo:[ThirdPhotos]
}

struct ThirdPhotos:Decodable {
    var title:String
    var url_t:String
}
