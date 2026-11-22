//
//  StockRepository.swift
//  SwiggyStock
//
//  Created by Shivam Gupta on 02/02/26.
//

import Foundation

protocol StockRepositoryProtocol {
    func fetchDataFromRemote() async -> [StockDetail]
}


class StockRepository: StockRepositoryProtocol {
    let service: StockServiceProtocol
    var stockResponse = [StockDetail]()

    init(service: StockServiceProtocol = StockService()) {
        self.service = service
    }

    func fetchDataFromRemote() async -> [StockDetail] {
        guard let url = URL(string: "https://api.tickertape.in/stocks/quotes?sids=RELI,TCS,ITC,HDBK,INFY") else { return [] }
        let result = await service.get(url: url, type: Stock1Model.self)
        switch result {
        case .success(let response):
            stockResponse = response.data
        case .failure(let error):
            print(error)
        }
        return stockResponse
    }

}
