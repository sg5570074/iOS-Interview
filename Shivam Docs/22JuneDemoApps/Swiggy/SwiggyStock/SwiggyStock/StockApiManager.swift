//
//  StockApiManager.swift
//  SwiggyStock
//
//  Created by Shivam Gupta on 07/05/25.
//

import Foundation

class StockApiManager {

    struct Constant {
        static var endPoint = "https://api.tickertape.in/stocks/quotes?sids=RELI,TCS,ITC,HDBK,INFY"
    }


    func callStockApi(completion: @escaping (([DataModel])->Void)) {

        guard let url = URL(string: Constant.endPoint) else { return }

        URLSession.shared.dataTask(with: url) { dataResponse, httpResponse, _ in

            if let responseData = dataResponse  {
                do {
                    let data =  try JSONDecoder().decode(StockModel.self, from: responseData)
                    print(data.data)
                    completion(data.data)

                }catch(let error) {
                    print(error)
                }

            }
        }.resume()
    }
}
