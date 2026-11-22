//
//  1Feb.swift
//  SwiftUIPractice
//
//  Created by Shivam Gupta on 01/02/26.
//

import SwiftUI

struct MenuList: View {
    @State private var selectedFruit = "Select Fruit"

    let fruits = ["Apple", "Banana", "Mango", "Orange"]
    var body: some View {
        VStack(spacing: 20) {

                    Menu {
                        ForEach(fruits, id: \.self) { fruit in
                            Button(fruit) {
                                selectedFruit = fruit
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedFruit)
                                .foregroundColor(.primary)

                        }
                        .padding()
                        .frame(width: 220)
                        .background(RoundedRectangle(cornerRadius: 8).stroke())
                    }

                    Text("Selected: \(selectedFruit)")
                        .font(.headline)
                }
                .padding()
    }
}

#Preview {
    MenuList()
}
