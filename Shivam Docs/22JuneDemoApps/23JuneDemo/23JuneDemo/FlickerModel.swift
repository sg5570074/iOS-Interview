//
//  FlickerModel.swift
//  23JuneDemo
//
//  Created by Shivam Gupta on 23/06/25.
//

import Foundation

struct FlickerResponseModel: Decodable {
    let photos: FlickerModel
}

struct FlickerModel: Decodable {
    let photo: [FlickerPhotos]
}


struct FlickerPhotos: Decodable {
    let url_t: String
    let title: String
    let height_t: Int
    let width_t: Int
}








//{
//  "photos": {
//    "page": 1,
//    "pages": 1714,
//    "perpage": 100,
//    "total": 171391,
//    "photo": [
//      {
//        "id": "50495564197",
//        "owner": "144779292@N03",
//        "secret": "60df9a123e",
//        "server": "65535",
//        "farm": 66,
//        "title": "Dance",
//        "ispublic": 1,
//        "isfriend": 0,
//        "isfamily": 0,
//        "url_t": "https://live.staticflickr.com/65535/50495564197_60df9a123e_t.jpg",
//        "height_t": 100,
//        "width_t": 67
//      }
//    ]
//  }
//}
