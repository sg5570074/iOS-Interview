//
//  CommnetService.swift
//  AppDeveloper
//
//  Created by Shivam on 28/03/26.
//

import Foundation

enum DemoError: Error {
    case BadURL
    case NOData
    case DecodingError
}


class CommnetService {
    func getComments() async -> Result<[CommentModel], Error> {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments") else { return .failure(DemoError.BadURL) }
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            let decodedData = try JSONDecoder().decode([CommentModel].self, from: data)
            return .success(decodedData)
        } catch let error {
            return .failure(error)
        }
    }
    
    func getCommentsUsingClosure(completion: @escaping ((Result<[CommentModel], Error>) -> ())) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments") else { return completion(.failure(DemoError.BadURL)) }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) {data,_,_ in
            do {
                if let data = data {
                    let decodedData = try JSONDecoder().decode([CommentModel].self, from: data)
                    completion(.success(decodedData))
                }
            } catch _ {
                completion(.failure(DemoError.DecodingError))
            }
            
        }.resume()
    }
    
    // How would you convert a closure-based API to async/await?
    func getCommentsUsingCheckedConituation() async -> Result<[CommentModel], Error> {
        await withCheckedContinuation { continuation in
            getCommentsUsingClosure { response in
                continuation.resume(returning: response)
                // continuation.resume(throwing: Never(from: error))
            }
        }
    }
    
    // Multiple task parallely
    
    func getParllelTask() async throws -> [CommentModel] {
        var response = [CommentModel]()
        
        try await withThrowingTaskGroup(of: Result<[CommentModel], Error>.self) { group in
            group.addTask {
               return await self.getCommentsUsingCheckedConituation()
            }
            
            group.addTask {
               return await self.getCommentsUsingCheckedConituation()
            }
            
            group.addTask {
               return await self.getCommentsUsingCheckedConituation()
            }
            for try await item in group {
                print(item)
                switch item {
                case .success(let model):
                    response = model
                case .failure(let error):
                    print(error)
                }
                
            }
        }
        
        return response
    }

}
