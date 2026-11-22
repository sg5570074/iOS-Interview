//
//  CurrencyViewModel.swift
//  31Oct
//
//  Created by Shivam Gupta on 31/10/25.
//

import Foundation

protocol CurrencyViewModelProtocol {
    func getCurrenctDictionary()
}
protocol ViewModelCallBackProtocol: AnyObject {
    func getCallBAckToView(_ curreny: [String:Double])
}

class CurrencyViewModel:CurrencyViewModelProtocol {
    private let repo: CurrencyRepositoryProtocol
    weak var currencyVMDelegate:ViewModelCallBackProtocol?

    init(repo: CurrencyRepositoryProtocol = CurrencyRepository()) {
        self.repo = repo
    }

    func getCurrenctDictionary() {
        Task {
            let currDict = await repo.getCurrencyRespositry()
            currencyVMDelegate?.getCallBAckToView(currDict)
        }
    }
}
