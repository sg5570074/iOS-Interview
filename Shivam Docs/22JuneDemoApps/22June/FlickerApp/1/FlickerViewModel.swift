//
//  FlickerViewModel.swift
//  FlickerApp
//
//  Created by Shivam Gupta on 21/06/25.
//

import Foundation

protocol FlickerViewModelDelegate: AnyObject {
    func giveCallBackResponse(_ photos: [Photo])
}

class FlickerViewModel {

    private var flickerSercvvice = FlickrService()
    weak var delegate: FlickerViewModelDelegate?

    func getSearchText(_ searchText: String) {

        if !searchText.isEmpty {
            do {
                try flickerSercvvice.getSeachedItems(searchText) { [weak self] response in
                    self?.delegate?.giveCallBackResponse(response.photos.photo)
                }
            } catch(let error) {
                print(error)
            }

        }
    }
}
