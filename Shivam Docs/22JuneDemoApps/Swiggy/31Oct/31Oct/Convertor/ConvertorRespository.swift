//
//  ConvertorRespository.swift
//  31Oct
//
//  Created by Shivam Gupta on 01/02/26.
//

import Foundation

protocol RepositoryProtocol {
    func getCurrnecy() async -> [String:Double]
}

class ConvertorRespository: RepositoryProtocol {
    let service: ServiceProtocol
    let urlFactory: URLFactoryProtocol
    private var currencyResponse = [String:Double]()

    init(service: ServiceProtocol = ConvertorService(), urlFactory:URLFactoryProtocol = URLFactory(environment: .teflon)) {
        self.service = service
        self.urlFactory = urlFactory
    }

    func getCurrnecy() async -> [String : Double] {
        let response = await service.getApi(url: urlFactory.makeCurrnecyURL()!, type: ConvertorModel.self)
        switch response {
        case .success(let data):
            currencyResponse = data.data
        case .failure(let error):
            print(error)
        }
        return currencyResponse
    }
    

}
