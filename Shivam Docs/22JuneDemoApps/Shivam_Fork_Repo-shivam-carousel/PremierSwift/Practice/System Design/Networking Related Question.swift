//
//  31Jan.swift
//  PremierSwift
//
//  Created by Shivam Gupta on 31/01/26.
//  Copyright © 2026 Deliveroo. All rights reserved.
//

import Foundation


//MARK: - Custom JsonDecoder
/*Response:
 
 {
   "success": {
     "data": "Some payload"
   }
 }

 {
   "error": {
     "code": 400,
     "message": "Bad request"
   }
 }

 */

enum APIResult {
    case success(SuccessResponse)
    case failure(ErrorResponse)
}


struct ApiResponse: Decodable {
    var response:APIResult

    private enum CodingKeys: String, CodingKey {
        case success
        case failure
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let scuess = try? container.decodeIfPresent(SuccessResponse.self, forKey: .success) {
            response = .success(scuess)
        }

        if let error = try? container.decodeIfPresent(ErrorResponse.self, forKey: .failure) {
            response = .failure(error)
        }else {
            throw DecodingError.dataCorrupted(.init(
                codingPath: decoder.codingPath,
                debugDescription: "Neither success nor error found"
            ))
        }
    }
}


struct SuccessResponse: Decodable {
    let data: String
    
}

struct ErrorResponse: Decodable {
    let code: Int
    let message: String
}

func fetchData() {
    var data = Data()
    do {
        let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
        switch apiResponse.response {
        case .success(let s):
            print("✅ Success data:", s.data)
        case .failure(let e):
            print("❌ Error:", e.message)
        }
    } catch(let error) {
        
    }
}

//MARK: - Suppose while calling an api with two different request, you are almost getting same response, but in that response one key might have Int or String Value. How you will handle it ?


struct HotelDTO: Decodable {
    var price:Int?

    private enum CodingKeys: String, CodingKey {
        case price
    }

    init(from decoder: any Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
        if let intPrice = try? container.decodeIfPresent(Int.self, forKey: .price) {
            price = intPrice
        }
        else if let stringPrice = try? container.decodeIfPresent(String.self, forKey: .price) {
            price = Int(stringPrice)
        } else {
            throw DecodingError.typeMismatch(
                Int.self, DecodingError.Context(
                    codingPath: [CodingKeys.price],
                    debugDescription: "String"
                )
            )
        }
    }
}


// MARK: - //Consume the API https://www.gutenberg.org/files/1342/1342-0.txt using URLSession.
class APIMAnager {
    func getAPI(_ url: URL) async throws -> String {
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        
        guard let text = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotDecodeContentData)
        }
        return text
    }
}


// MARK: -

//Q2>🔹 Problem Summary
//Parent1 → struct (shared model)
//DataModel1 → has Parent1
//DataModel2 → also has Parent1
//ParentDataModel → contains both DataModel1 & DataModel2
//
//👉 Issue:
//
//DataModel2 receives wrong/mismatched key
//You want to know:
//👉 How to identify where decoding failed?

//ParentDataModel → dataModel2 → parent1 → name

//func printDecodingError(_ error: DecodingError) {
//    switch error {
//
//    case .keyNotFound(let key, let context):
//        let path = context.codingPath.map { $0.stringValue }
//
//        print("❌ Missing key:", key.stringValue)
//        print("📍 Full Path:", path.joined(separator: " → "))
//
//        if path.count >= 2 {
//            print("🔥 Issue likely in:", path[path.count - 2]) // parent container
//        }
//
//    case .typeMismatch(_, let context):
//        let path = context.codingPath.map { $0.stringValue }
//
//        print("📍 Full Path:", path.joined(separator: " → "))
//
//        if path.count >= 1 {
//            print("🔥 Issue in model:", path.last ?? "")
//        }
//
//    default:
//        print(error)
//    }
//}
//🔥 Output Now
//❌ Missing key: name
//📍 Full Path: parentDataModel → dataModel2 → parent1 → name
//🔥 Issue likely in: parent1

//👉 You don’t need custom init in every model
//
//Because:
//
//codingPath already gives full hierarchy
//You just need to interpret or format it properly

//struct Root: Decodable {
//    let company: Company
//}
//
//struct Company: Decodable {
//    let employee: Employee
//}
//
//struct Employee: Decodable {
//    let address: Address
//}
//
//struct Address: Decodable {
//    let zipCode: Int
//}
//
//let json = """
//{
//  "company": {
//    "employee": {
//      "address": {
//        "zipCode": "560001A"
//      }
//    }
//  }
//}
//""".data(using: .utf8)!
//
//do {
//
//    let _ = try JSONDecoder().decode(Root.self, from: json)
//
//} catch let DecodingError.typeMismatch(_, context) {
//
//    let path = context.codingPath
//        .map { $0.stringValue }
//        .joined(separator: ".")
//
//    print("Failed at path:")
//    print(path)
//
//    print(context.debugDescription)
//}
//
//Failed at path:
//company.employee.address.zipCode
//
//Expected to decode Int but found a string instead.
