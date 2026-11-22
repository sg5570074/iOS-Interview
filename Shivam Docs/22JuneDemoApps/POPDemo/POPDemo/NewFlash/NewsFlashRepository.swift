//
//  NewsFlashRepository.swift
//  POPDemo
//
//  Created by Shivam Gupta on 25/11/25.
//

import Foundation

protocol NewsFlashRepositoryProtocol {
    func getNewFlashData(completion: @escaping ([NewsSourceModel])->())
}

class NewsFlashRepository:NewsFlashRepositoryProtocol {
    var apiService: ApiManagerProtocol

    init(apiService: ApiManagerProtocol = ApiManager()) {
        self.apiService = apiService
    }

    func getNewFlashData(completion: @escaping ([NewsSourceModel]) -> ()) {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines/sources?apiKey=66b9e8c650ad4c82be4537b20dc60fff") else {
            return
        }
        Task {
            let response = await apiService.getApi(url, type: NewsFLashModel.self)

            switch response {
            case .success(let response):
                guard let data = response.sources else { return }
                completion(data)
            case .failure(let error):
                print("error")
            }
        }
    }
}
