//
//  StockModel.swift
//  SwiggyStock
//
//  Created by Shivam Gupta on 07/05/25.
//


struct StockModel: Decodable {
    var success: Bool
    var data: [DataModel]
}

struct DataModel: Decodable {
    var sid: String
    var price: Float
    var change: Float
}


//{
//  "success": true,
//  "data_": [
//    {
//      "sid": "RELI",
//      "price": 1406,
//      "close": 1420.9,
//      "change": -14.9,
//      "high": 1424.4,
//      "low": 1402.7,
//      "volume": 13440169,
//      "date": "2025-05-07T10:29:16.000Z"
//    },
//    {
//      "sid": "TCS",
//      "price": 3445.1,
//      "close": 3460,
//      "change": -14.9,
//      "high": 3459.5,
//      "low": 3420.6,
//      "volume": 1477128,
//      "date": "2025-05-07T10:29:35.000Z"
//    },
//    {
//      "sid": "ITC",
//      "price": 431.15,
//      "close": 435.55,
//      "change": -4.4,
//      "high": 435,
//      "low": 429.7,
//      "volume": 9710361,
//      "date": "2025-05-07T10:27:47.000Z"
//    },
//    {
//      "sid": "INFY",
//      "price": 1508.3,
//      "close": 1511.5,
//      "change": -3.2,
//      "high": 1518.8,
//      "low": 1496.6,
//      "volume": 5691799,
//      "date": "2025-05-07T10:29:53.000Z"
//    }
//  ]
//}
