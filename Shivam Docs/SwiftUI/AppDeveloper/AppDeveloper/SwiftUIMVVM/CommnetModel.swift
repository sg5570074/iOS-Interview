//
//  CommnetModel.swift
//  AppDeveloper
//
//  Created by Shivam on 28/03/26.
//
import Foundation

struct CommentModel: Decodable, Identifiable {
    let postID, id: Int
    let name, email, body: String
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}


//{
//    "postId": 1,
//    "id": 1,
//    "name": "id labore ex et quam laborum",
//    "email": "Eliseo@gardner.biz",
//    "body": "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium"
//  }
