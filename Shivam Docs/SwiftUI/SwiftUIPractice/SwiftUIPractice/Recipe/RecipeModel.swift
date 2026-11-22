//
//  RecipeModel.swift
//  SwiftUIPractice
//
//  Created by Shivam Gupta on 03/02/26.
//

import Foundation

struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let ingredients: [String]
}


