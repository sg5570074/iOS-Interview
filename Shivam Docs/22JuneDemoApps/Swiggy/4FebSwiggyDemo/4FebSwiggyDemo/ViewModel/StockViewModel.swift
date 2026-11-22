//
//  StockViewModel.swift
//  4FebSwiggyDemo
//
//  Created by Shivam Gupta on 04/02/26.
//

import Foundation

protocol StockViewModelProtocol {
    func getStockData(completion: @escaping(([StockDetails])->()))
}


class StockViewModel: StockViewModelProtocol {
    private var repo: StockRepositoryProtocol

    init(repo: StockRepositoryProtocol = StockRepository()) {
        self.repo = repo
    }

    func getStockData(completion: @escaping ([StockDetails]) -> ()) {
        Task { [weak self] in
            let stcokData = await self?.repo.fetchDataFromRemote()
            completion(stcokData ?? <#default value#>)
        }
        
    }
}
