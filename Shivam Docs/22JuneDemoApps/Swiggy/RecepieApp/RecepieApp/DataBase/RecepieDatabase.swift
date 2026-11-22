//
//  RecepieDatabase.swift
//  RecepieApp
//
//  Created by Shivam Gupta on 27/02/25.
//

import Foundation


class DBManager {
    static let shared = DBManager()
    private var listOfRecepie = [Recepie]()

    private init() {}


    func addRecepie(_ recepie: Recepie) {
        listOfRecepie.append(recepie)
    }

    func getRecepieList() -> [Recepie] {
        return listOfRecepie
    }

}
