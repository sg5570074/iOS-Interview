//
//  RecepieViewModel.swift
//  RecepieApp
//
//  Created by Shivam Gupta on 27/02/25.
//

import Foundation

class RecepieViewModel {

    func validateAndaddReceipe(_ name: String?, _ ingredeint: String?) -> Bool {
        guard let name, !name.isEmpty,
              let ingredeint, !ingredeint.isEmpty else {
                  return false
              }

        let ingredientArr = ingredeint.components(separatedBy: ",")
        let model = Recepie(name: name, ingredient: ingredientArr)
        DBManager.shared.addRecepie(model)
        return true
    }

    func loadRecepie() -> [Recepie] {
        return DBManager.shared.getRecepieList()
    }

//    func deleteReceipe(_ id: Int, completion:@escaping (Bool)->Void) {
//
//        completion(DBManager.shared.deleteReceipe(id))
//    }
}
