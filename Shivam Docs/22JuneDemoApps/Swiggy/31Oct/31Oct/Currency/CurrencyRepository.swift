//
//  CurrencyRepository.swift
//  31Oct
//
//  Created by Shivam Gupta on 31/10/25.
//

import Foundation

protocol CurrencyRepositoryProtocol {
    func getCurrencyRespositry() async -> [String:Double]
}

class CurrencyRepository: CurrencyRepositoryProtocol {
    let networkManager: NetworkManager
    private var currencyResponse = [String:Double]()
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }

    var dict = [
        "AUD": 1.5246002493,
        "BGN": 1.690300206,
        "BRL": 5.3837008835,
        "CAD": 1.3981901447,
        "CHF": 0.8016100992,
        "CNY": 7.1097008387,
        "CZK": 21.0286038215,
        "DKK": 6.4535007654,
        "EUR": 0.8642000938,
        "GBP": 0.7599801098,
        "HKD": 7.7696009217,
        "HRK": 6.5109791835,
        "HUF": 335.5900473278,
        "IDR": 16619.3027789,
        "ILS": 3.2530004489,
        "INR": 88.634814238,
        "ISK": 125.1300204849,
        "JPY": 153.9060284056,
        "KRW": 1430.4892731781,
        "MXN": 18.5370032046,
        "MYR": 4.1988007877,
        "NOK": 10.0543014752,
        "NZD": 1.7409001796,
        "PHP": 58.8660076489,
        "PLN": 3.6647005636,
        "RON": 4.3936006759,
        "RUB": 79.9489081876,
        "SEK": 9.4379014383,
        "SGD": 1.2998102335,
        "THB": 32.3300056526,
        "TRY": 42.0276066939,
        "USD": 1,
        "ZAR": 17.2743017325
      ]

    func getCurrencyRespositry() async -> [String:Double] {
        guard let url = URL(string: "https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_qdi94nhAyU5aBS2X0TbgC9CtAwqNZNFKWKR9bUFN") else {
            return [:]
        }

        let currencyData = await networkManager.getApi(url, resposnseType: CurrencyModel.self)

        switch currencyData {
        case .success(let data):
            currencyResponse = data.data
        case .failure(let error):
            print(error)
            //currencyResponse = dict
        }
        return currencyResponse
    }

}
