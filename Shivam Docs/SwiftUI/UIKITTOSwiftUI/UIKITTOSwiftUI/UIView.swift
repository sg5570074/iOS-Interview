//
//  UIView.swift
//  UIKITTOSwiftUI
//
//  Created by Shivam on 30/04/26.
//

import SwiftUI
import Combine

struct UIViewDemo: View {
    @Environment(ViewModel.self) var vm
    var body: some View {
        VStack {
            ForEach(1...vm.numberofViews, id: \.self) { value in
                Text("Shivam \(value)")
                    .foregroundColor(.red)
            }
        }

    }
}

#Preview {
    UIView()
}
