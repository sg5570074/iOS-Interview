//
//  ContentView.swift
//  SwiftUIPractice
//
//  Created by Shivam Gupta on 26/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var userName = ""
    @State private var password = ""

    var body: some View {
        NavigationView {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .padding()
                Text("Learin SWiftUI with Shivam")
                    .font(.subheadline)
                    .padding()
                TextField("UserName", text: $userName)
                    .padding()
                    .cornerRadius(10)
                    .background(Color(.systemGray6))
                SecureField("Paswrod", text: $password)
                    .padding()
                    .cornerRadius(10)
                    .background(Color(.systemGray6))
                HStack {
                    Button("Login") {
                        print("Login Tapped")
                    }
                    Spacer()
                    Button("Forgot Passsword") {
                        print("Forgot Passsword Tapped")
                    }
                }
                Spacer(minLength: 30)
                NavigationLink(destination: Text("Home")) {
                    Text("Home")
                }
            }.padding()
        }
    }
}


//struct ViewToViewController: UIViewControllerRepresentable {
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        <#code#>
//    }
//    
//
//    func makeUIViewController(context: Context) -> some UIViewController {
//
//    }
//
//}

#Preview {
    ContentView()
}



struct HomeView: View {
    var body: some View {
        NavigationView {
            
        }
    }
}




