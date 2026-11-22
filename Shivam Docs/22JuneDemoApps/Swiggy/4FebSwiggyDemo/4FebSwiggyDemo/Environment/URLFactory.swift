//
//  URLFactory.swift
//  4FebSwiggyDemo
//
//  Created by Shivam Gupta on 04/02/26.
//

import Foundation

enum Environment {
    case teflon
    case prod

    var baseURL: String {
        switch self {
        case .prod:
            return ""
        case .teflon:
            return "https://api.tickertape.in"
        }
    }
}

protocol URLFactoryProtocol {
    func stockURl() -> URL?
}

class URLFactory: URLFactoryProtocol {
    var env: Environment

    init(env: Environment) {
        self.env = env
    }

    func stockURl() -> URL? {
        var path = "/stocks/quotes?sids=RELI%2CTCS%2CITC%2CHDBK%2CINFY"
        let url = URL(string: env.baseURL+path)
        return url
    }

    
}

