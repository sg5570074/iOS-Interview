//
//  FlickrData.swift
//  Procore-Coding-Round
//
//  Created by Soham Bhattacharjee on 23/04/25.
//

import Foundation

struct FlickrData: Codable {
    private(set) var photos: FlickrPhoto?
}

struct FlickrPhoto: Codable {
    private(set) var photo: [Photo]?
}

final class Photo: Codable, Hashable {
    let id: String
    private(set) var title: String?
    private(set) var height_t: Int?
    private(set) var width_t: Int?
    private(set) var url_t: String?
    
    var subTitle: String {
        if let width_t, let height_t {
            return "\(width_t) x \(height_t)"
        }
        return ""
    }
    
    var localURL: URL? {
        do {
            let docDir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let rootPhotoDir = docDir.appendingPathComponent("Photos")
        } catch {
            return nil
        }
        return nil
    }
    
    static func ==(lhs: Photo, rhs: Photo) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
