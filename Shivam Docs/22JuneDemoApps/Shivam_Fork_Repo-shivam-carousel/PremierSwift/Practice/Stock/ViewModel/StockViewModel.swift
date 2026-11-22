//
//  StockViewModel.swift
//  SwiggyStock
//
//  Created by Shivam Gupta on 02/02/26.
//

protocol StockViewModelProtocol {
    func fetchDataFromRepo(completion: @escaping ([StockDetail])->())
}

class Stock1ViewModel: StockViewModelProtocol {
    var repository: StockRepositoryProtocol
    
    init(repository: StockRepositoryProtocol = StockRepository()) {
        self.repository = repository
    }

    func fetchDataFromRepo(completion: @escaping ([StockDetail])->()) {
        Task {
           let stockDetails = await repository.fetchDataFromRemote()
           completion(stockDetails)
        }
    }
}
