//
//  List.swift
//  SwiftUIPractice
//
//  Created by Shivam Gupta on 27/07/25.
//

import SwiftUI

struct Student: Identifiable {
    var id: Int

    var name:String
}

struct StudentList: View {

    @State private var studentArr = [
        Student(id: 1, name: "Shivam"),
        Student(id: 2, name: "jksfdnl"),
        Student(id: 3, name: "hjshdfk")
    ]
    var body: some View {
        List
        {
            ForEach(studentArr, id: \.id){ student in
                Text(student.name)
                Button("asfgd") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
            }.onDelete(perform: deleteStudent)
        }
    }

    func deleteStudent(index: IndexSet) {
        studentArr.remove(atOffsets: index)
    }
}

#Preview {
    StudentList()
}
