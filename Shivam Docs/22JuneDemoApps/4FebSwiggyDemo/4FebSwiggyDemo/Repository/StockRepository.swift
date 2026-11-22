//
//  StockRepository.swift
//  4FebSwiggyDemo
//
//  Created by Shivam Gupta on 04/02/26.
//

import Foundation

protocol StockRepositoryProtocol {
    func fetchDataFromRemote() async -> [StockDetails]
}

class StockRepository: StockRepositoryProtocol {
    private let service: StockServiceProtocol
    private let urlFactory: URLFactoryProtocol
    private var stockDetails = [StockDetails]()

    init(service: StockServiceProtocol = StockService(), urlFactory: URLFactoryProtocol = URLFactory(env: .teflon)) {
        self.service = service
        self.urlFactory = urlFactory
    }


    func fetchDataFromRemote() async -> [StockDetails] {
        guard let url = urlFactory.stockURl() else {
            return []
        }

        let response = try? await service.get(url: url, type: StockModel.self)

        switch response {
        case .success(let data):
            stockDetails = data.data ?? []
        case .failure(let error):
            print(error)
        case .none:
            print("Nothing")
        }
        return stockDetails
    }
}
