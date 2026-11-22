//
//  NewsFLashModel.swift
//  POPDemo
//
//  Created by Shivam Gupta on 25/11/25.
//

import Foundation

struct NewsFLashModel: Decodable {
    var status:String
    var sources:[NewsSourceModel]?
}

struct NewsSourceModel: Decodable {
    var id:String
    var name:String?
    var description:String?
    var url:String?
    var category:String?
}



