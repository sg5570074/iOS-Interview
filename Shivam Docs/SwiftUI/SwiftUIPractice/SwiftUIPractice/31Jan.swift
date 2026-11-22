//
//  31Jan.swift
//  SwiftUIPractice
//
//  Created by Shivam Gupta on 31/01/26.
//

import SwiftUI

struct Jan31: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: "https://picsum.photos/300")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    case .failure(_):
                        Text(verbatim: "")
                    @unknown default:
                        EmptyView()
                    }
                }
                Menu("Currency") {
                    ForEach((1...10), id: \.self) {

                        Text("Shivam\($0)")
                    }
                }


                Rectangle()
                    .foregroundColor(.pink)
                Button("Press ME") {
                    SecondVC()
                    print("clicked")
                }
                NavigationLink("Next Page") {
                    SecondVC()
                }

            }
        }


    }
}

struct SecondVC: View {
    var body: some View {
        Rectangle().foregroundColor(.orange)
    }
}

#Preview {
    Jan31()
}
