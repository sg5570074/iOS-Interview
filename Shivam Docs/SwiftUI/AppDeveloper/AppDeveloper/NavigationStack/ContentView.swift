//
//  ContentView.swift
//  AppDeveloper
//
//  Created by Shivam on 28/03/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var router: Router
    var body: some View {
        VStack {
            Button("Go To View1") {
                router.pushView(route: .View1)
            }
        }
        .navigationTitle("ContentView")
        .padding()
        
    }
}


struct View1: View {
    @EnvironmentObject private var router: Router
    var body: some View {
        VStack {
            Button("Go To View2") {
                router.pushView(route: .View2)
            }
        }
        .navigationTitle("View1")
        .padding()
        
    }
}

struct View2: View {
    @EnvironmentObject private var router: Router
    var body: some View {
        VStack {
            Button("Go To View3") {
                router.pushView(route: .View3("Hello"))
            }
        }
        .navigationTitle("View2")
        .padding()
        
    }
}


struct View3: View {
    let name: String
    @EnvironmentObject private var router: Router
    var body: some View {
        VStack {
            Button("Go To Root View") {
                router.popToRootView()
            }
            
            Button("Go To View1") {
                router.popToSepecificView(k: 2)
            }
        }
        .navigationTitle("View3")
        .padding()
        
    }
}
