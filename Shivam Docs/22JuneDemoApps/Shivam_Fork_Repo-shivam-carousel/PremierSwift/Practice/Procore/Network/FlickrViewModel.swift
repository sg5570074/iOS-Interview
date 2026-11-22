//
//  FlickrViewModel.swift
//  Procore-Coding-Round
//
//  Created by Soham Bhattacharjee on 23/04/25.
//

import Foundation
import Combine

enum UIUpdate {
    case loaded
    case loading
    case refresh(Photo)
    case failed(FlickrError)
}

final class FlickrViewModel {
    private(set) var photos: [Photo] = []
    let onUIUpdate: PassthroughSubject = PassthroughSubject<UIUpdate, Never>()
    private var fetcher = Fetcher()
    
    func search(_ query: String) {
        Task(priority: .userInitiated) { [weak self] in
            guard let self else { return }
            
            let result = await self.fetcher.search(query)
            switch result {
            case .success(let photos):
                self.photos = photos
                self.onUIUpdate.send(.loaded)
            case .failure(let failure):
                self.onUIUpdate.send(.failed(failure))
            }
        }
    }
    
    
}
