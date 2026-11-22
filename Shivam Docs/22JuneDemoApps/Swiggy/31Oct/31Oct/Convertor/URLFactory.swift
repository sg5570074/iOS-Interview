//
//  URLFactory.swift
//  31Oct
//
//  Created by Shivam Gupta on 01/02/26.
//

import Foundation

enum Environment {
    case teflon
    case prod

    var baseURL: String {
        switch self {
        case .teflon:
            return "https://api.freecurrencyapi.com/v1"
        case .prod:
            return ""
        }
    }
}


protocol URLFactoryProtocol {
    func makeCurrnecyURL() -> URL?
}

final class URLFactory: URLFactoryProtocol {
    private let environment: Environment

    init(environment: Environment) {
        self.environment = environment
    }

    func makeCurrnecyURL() -> URL? {
        let path = "/latest?apikey=fca_live_qdi94nhAyU5aBS2X0TbgC9CtAwqNZNFKWKR9bUFN"
        let urlString = "\(environment.baseURL)\(path)"
        return URL(string: urlString)
    }
}
