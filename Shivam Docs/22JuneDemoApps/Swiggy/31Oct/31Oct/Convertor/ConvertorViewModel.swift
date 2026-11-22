//
//  ConvertorViewModel.swift
//  31Oct
//
//  Created by Shivam Gupta on 01/02/26.
//
import Foundation

protocol ConvertorViewModelProtocol {
    func getCurrenctDictionary(completion: @escaping(([String:Double])->()))
}

class ConvertorViewModel: ConvertorViewModelProtocol {
    var respositriy:RepositoryProtocol
    init(respositriy: RepositoryProtocol = ConvertorRespository()) {
        self.respositriy = respositriy
    }

    func getCurrenctDictionary(completion: @escaping ([String : Double]) -> ()) {
        Task {
           let data = await respositriy.getCurrnecy()
           completion(data)
        }
    }
}
