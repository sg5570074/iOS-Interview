//
//  ContentView.swift
//  AppDeveloper
//
//  Created by Shivam on 28/03/26.
//

import SwiftUI

struct CommnetView: View {
    @ObservedObject var viewmodel = CommentViewModel()
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewmodel.comments) { comment in
                        NavigationLink {
                            DetailView(commentModel: comment)
                        } label: {
                            CommentRow(commentModel: comment)
                        }

                    }
                }
            }.onAppear {
                viewmodel.fetchComments()
            }.navigationTitle("Comment List")
        }
    }
}

#Preview {
    CommnetView()
}

