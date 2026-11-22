//
//  SwiftDataContentView.swift
//  AppDeveloper
//
//  Created by Shivam on 01/05/26.
//

import SwiftUI
import SwiftData

struct SwiftDataContentView: View {
    
    @Environment(\.modelContext)private var context
    @Query private var dataItems:[DataItem]
    var body: some View {
        VStack {
            Text("SwiftData Demo")
                .font(.title)
            Button {
                saveDateItem()
            } label: {
                Text("Save Data")
            }
            // 👉 Use this when you need more control inside the List
            List {
                ForEach(dataItems) { item in
                    HStack {
                        Text(item.name)
                        Spacer()
                        Button  {
                            updateItem(item)
                        } label: {
                            Image(systemName: "heart.fill")
                        }

                    }
                   
                }
                .onDelete { indexes in
                    let itemsToDelete = indexes.map { dataItems[$0] }
                    
                    for item in itemsToDelete {
                        context.delete(item)
                    }
                    
                }
            }
            
            //👉 Use this when:
            //            You only have one collection
            //            No extra views needed
            //            Clean & simple list
            //            onDelete wont work
            //            List(dataItems) { item in
            //                Text(item.name)
            //            }
            
            
        }
    }
    
    func saveDateItem() {
        let item = DataItem(name: "Shivam")
        print(item)
        context.insert(item)
        print(dataItems.count)
    }
    
    func deleteItem(_ item: DataItem) {
        context.delete(item)
    }
    
    func updateItem(_ item: DataItem) {
        item.name = "Gupta"
        try? context.save()
    }
    
    
    
}
