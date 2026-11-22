//
//  SwiftDataModel.swift
//  AppDeveloper
//
//  Created by Shivam on 01/05/26.
//

import Foundation
import SwiftData

@Model
class DataItem {
    var name:String
    var id:String
    
    init(name: String, id: String = UUID().uuidString) {
        self.name = name
        self.id = id
    }
}
