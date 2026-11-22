//
//  CommentRow.swift
//  AppDeveloper
//
//  Created by Shivam on 28/03/26.
//

import SwiftUI

struct CommentRow: View {
    var commentModel:CommentModel
    var body: some View {
        VStack {
            Text(commentModel.name)
                .font(.headline)
            Text(commentModel.email)
                .font(.subheadline)
        }
    }
}

#Preview {
    CommentRow(commentModel: CommentModel(postID: 1, id: 1, name: "Shivam", email: "s@gmail.com", body: "MVVM "))
}
