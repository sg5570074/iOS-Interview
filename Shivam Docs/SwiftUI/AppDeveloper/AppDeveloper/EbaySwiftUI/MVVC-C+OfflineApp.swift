//
//  offlineApp.swift
//  AppDeveloper
//
//  Created by Shivam on 16/05/26.
//

import Foundation
import Swift
import SwiftUI
import Combine


//MARK: - 1️⃣ Environment Enum
enum Environment {
    case teflon
    case production
    
    var baseURL: String {
        switch self {
        case .teflon: return "https://teflon.expedia.com"
        case .production: return "https://api.expedia.com"
        }
    }
}

//MARK: - 2️⃣ URLFactory

protocol URLFactoryProtocol {
    func makeHotelSearchURL(city: String) -> URL?
}

final class URLFactory: URLFactoryProtocol {
    private let environment: Environment
    
    init(environment: Environment) {
        self.environment = environment
    }
    
    func makeHotelSearchURL(city: String) -> URL? {
        let path = "/hotels"
        let urlString = "\(environment.baseURL)\(path)?city=\(city)"
        return URL(string: urlString)
    }
}


//MARK: - 3️⃣ DTO + Domain + Adapter
struct HotelDTO: Codable {
    let id: String
    let name: String
    let price: Double
    let imageUrl: String
}

struct Hotel {
    let id: String
    let name: String
    let formattedPrice: String
    let imageUrl: String
}

extension HotelDTO {
    func toDomain() -> Hotel {
        Hotel(
            id: id,
            name: name,
            formattedPrice: "$\(price)",
            imageUrl: imageUrl
        )
    }
}


//MARK: - 4️⃣ Network Layer
protocol NetworkServiceProtocol {
    func get<T: Decodable>(_ url: URL) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    func get<T>(_ url: URL) async throws -> T where T : Decodable {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}


//MARK: - 📶 Network Monitoring
final class NetworkMonitor {
    var isOnline: Bool { return true }
}


//MARK: - Local Storage Layer
protocol HotelLocalStoreProtocol {
    func fetchHotels() -> [Hotel]
    func saveHotels(_ hotels: [Hotel])
}

class HotelLocalStore: HotelLocalStoreProtocol {
    func fetchHotels() -> [Hotel] {
        return []
    }
    
    func saveHotels(_ hotels: [Hotel]) {
    }
    
}


//MARK: - 5️⃣ Repository (uses URLFactory)

protocol HotelRepositoryProtocol {
    func searchHotels(city: String) async throws -> [Hotel]
}

final class HotelRepository: HotelRepositoryProtocol {
    private let local: HotelLocalStoreProtocol = HotelLocalStore()
    private let network: NetworkServiceProtocol
    private let urlFactory: URLFactoryProtocol
    private let reachability: NetworkMonitor = NetworkMonitor()
    
    init(network: NetworkServiceProtocol, urlFactory: URLFactoryProtocol) {
        self.network = network
        self.urlFactory = urlFactory
    }

    func searchHotels(city: String) async throws -> [Hotel] {
        if reachability.isOnline {
            guard let url = urlFactory.makeHotelSearchURL(city: city) else {
                throw URLError(.badURL)
            }
            let dtoList: [HotelDTO] = try await network.get(url)
            return dtoList.map { $0.toDomain() }
        } else {
            let cached = local.fetchHotels()
            return cached
        }
        
        
    }
}


//MARK: - 6️⃣ ViewModel (ObservableObject with @Published)

@MainActor
final class HotelSearchViewModel: ObservableObject {
    @Published var hotels: [Hotel] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let repository: HotelRepositoryProtocol
    
    init(repository: HotelRepositoryProtocol) {
        self.repository = repository
    }

    func search(city: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            hotels = try await repository.searchHotels(city: city)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}


//MARK: - 8️⃣ App Setup (Dependency Injection)
let environment: Environment = .teflon
let factory = URLFactory(environment: environment)
let network = NetworkService()
let repository = HotelRepository(network: network, urlFactory: factory)
let viewModel = HotelSearchViewModel(repository: repository)
//let vc = HotelSearchViewController(viewModel: viewModel)




