//
//  AppDeveloperApp.swift
//  AppDeveloper
//
//  Created by Shivam on 28/03/26.
//

import SwiftUI
import SwiftData

@main
struct AppDeveloperApp: App {
    var body: some Scene {
        WindowGroup {
            // MARK: withCheckedContinuation, withThrowingTaskGroup
            // CommnetView()
            
            // MARK:  Navigation Stack
            //AppContainerView()
            
            // MARK: Swift Data Basics and Listt/ onDelete
           // SwiftDataContentView()
            
            // MARK: -  Ebay
           // EbayContentView()
            
           // MARK: - Pagination
            FeedPaginationView()
            
            
        }
        .modelContainer(for: DataItem.self)
    }
}
