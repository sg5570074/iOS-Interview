//
//  RecipeViewModel.swift
//  SwiftUIPractice
//
//  Created by Shivam Gupta on 03/02/26.
//

import Foundation
import SwiftUI

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var searchText: String = ""

    init() {
        print("kjs")
    }

    var filteredRecipes: [Recipe] {
        guard !searchText.isEmpty else { return recipes }

        return recipes.filter { recipe in
            recipe.ingredients.contains {
                $0.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    func addRecipe(name: String, ingredientsText: String) {
        let ingredients = ingredientsText
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }

        let recipe = Recipe(name: name, ingredients: ingredients)
        recipes.append(recipe)
    }
}
