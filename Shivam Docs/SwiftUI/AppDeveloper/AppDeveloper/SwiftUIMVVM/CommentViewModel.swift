//
//  CommentViewModel.swift
//  AppDeveloper
//
//  Created by Shivam on 28/03/26.
//

import Foundation
import Combine

//@MainActor
class CommentViewModel: ObservableObject {
    @Published var comments: [CommentModel] = []
    
    func fetchComments() {
        Task {
            if Thread.isMainThread {
                print("MainThread1")
            }
            let response = await CommnetService().getCommentsUsingCheckedConituation()
            switch response {
            case .success(let comments):
                self.comments = comments
            case .failure(let error):
                print(error)
            }
            
            if Thread.isMainThread {
                print("MainThread2")
            }
        }
        
    }
    
   
}
