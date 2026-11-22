//
//  StockViewModel.swift
//  SwiggyStock
//
//  Created by Shivam Gupta on 07/05/25.
//

import Foundation

class StockViewModel {

    let apiResource = StockApiManager()
    var data = [DataModel]()

    func getStockData(_ completion: @escaping (([DataModel])->Void)){

        apiResource.callStockApi { stockModel in
            completion(stockModel)
        }
    }
}
