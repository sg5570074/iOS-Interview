//
//  ApiCaller.swift
//  RecepieApp
//
//  Created by Shivam Gupta on 07/05/25.
//

import Foundation

class ApiCaller {

    var isPagination = false
    func callCountyList(pagination: Bool, completion: @escaping ((Result<[Recepie], Error>) -> Void)) {
        if pagination {
            isPagination = true
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2)) {
            let mockData  = [
                Recepie(name: "Pizza", ingredient: ["paneer,tomato"]),
                Recepie(name: "Pizza", ingredient: ["paneer,tomato"]),
                Recepie(name: "Pizza", ingredient: ["paneer,tomato"]),
                Recepie(name: "Pizza", ingredient: ["paneer,tomato"]),
                Recepie(name: "Pizza", ingredient: ["paneer,tomato"]),
                Recepie(name: "Pizza", ingredient: ["paneer,tomato"]),
                Recepie(name: "Pizza", ingredient: ["paneer,tomato"]),
                Recepie(name: "Burger", ingredient: ["paneer,cheese"]),
                Recepie(name: "Burger", ingredient: ["paneer,cheese"]),
                Recepie(name: "Burger", ingredient: ["paneer,cheese"]),
                Recepie(name: "Burger", ingredient: ["paneer,cheese"]),
                Recepie(name: "Burger", ingredient: ["paneer,cheese"]),
                Recepie(name: "Pizza", ingredient: ["paneer,tomato"]),
                Recepie(name: "Pizza", ingredient: ["paneer,tomato"]),
                Recepie(name: "Pizza", ingredient: ["paneer,tomato"]),
                Recepie(name: "Pizza", ingredient: ["paneer,tomato"]),
                Recepie(name: "Pizza", ingredient: ["paneer,tomato"]),
                Recepie(name: "Pizza", ingredient: ["paneer,tomato"]),
                Recepie(name: "Pizza", ingredient: ["paneer,tomato"]),
                Recepie(name: "Burger", ingredient: ["paneer,cheese"]),
                Recepie(name: "Burger", ingredient: ["paneer,cheese"]),
                Recepie(name: "Burger", ingredient: ["paneer,cheese"]),
                Recepie(name: "Burger", ingredient: ["paneer,cheese"]),
                Recepie(name: "Burger", ingredient: ["paneer,cheese"])
            ]

            let newData = [
                Recepie(name: "Momo", ingredient: ["paneer,veg"]),
                Recepie(name: "Momo", ingredient: ["paneer,veg"]),
                Recepie(name: "Momo", ingredient: ["paneer,veg"]),
                Recepie(name: "Momo", ingredient: ["paneer,veg"]),
                Recepie(name: "Momo", ingredient: ["paneer,veg"]),
                Recepie(name: "Momo", ingredient: ["paneer,veg"])
            ]

            completion(.success(pagination ? newData : mockData))
            if pagination {
                self.isPagination = false
            }
        }

    }
}
