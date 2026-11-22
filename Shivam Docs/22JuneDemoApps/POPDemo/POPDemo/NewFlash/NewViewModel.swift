//
//  NewViewModel.swift
//  POPDemo
//
//  Created by Shivam Gupta on 25/11/25.
//

protocol NewsFlashViewModelProtocol {
    func getNewRepositoryData(completion: @escaping(([NewsSourceModel])->()))
}


class NewsFlashViewModel: NewsFlashViewModelProtocol {
    private var resposirty: NewsFlashRepositoryProtocol

    init(resposirty: NewsFlashRepositoryProtocol =  NewsFlashRepository()) {
        self.resposirty = resposirty
    }

    func getNewRepositoryData(completion: @escaping(([NewsSourceModel])->())) {
        resposirty.getNewFlashData { newsSourceData in
            completion(newsSourceData)
        }
    }

    
}
