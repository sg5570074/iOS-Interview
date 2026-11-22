//
//  SwiftUIView.swift
//  SwiftUIPractice
//
//  Created by Shivam on 26/03/26.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        GeometryReader { geo in
            Rectangle()
              .frame(width: geo.size.width * 0.8, height: 100)
              
        }
        .background(Color.green)
        .frame(height: 100)
        
        GeometryReader { geo in
            Text("Position: \(geo.frame(in: .global).minY)")
        }
    }
}

#Preview {
    SwiftUIView()
}
