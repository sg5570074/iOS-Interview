//
//  Router.swift
//  AppDeveloper
//
//  Created by Shivam on 28/03/26.
//

import Foundation
import SwiftUI
import Combine

enum Route: Hashable {
    case ContentView
    case View1
    case View2
    case View3(String) // pass any Model or data
}

final class Router: ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    func pushView(route: Route) {
        navigationPath.append(route)
    }
    
    func popToRootView() {
        navigationPath = .init()
    }
    
    func popToSepecificView(k: Int) {
        navigationPath.removeLast(k)
    }
    
}
