//
//  ContentView.swift
//  SimpleTodo
//
//  Created by Mohammad Azam on 5/16/22.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @State private var title: String = ""
    
    @SectionedFetchRequest<Bool,Task>(sectionIdentifier: \.isCompleted, sortDescriptors: [SortDescriptor(\.isCompleted)]) private var taskSections
    
    private func save() {
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
             
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        let task = Task(context: viewContext)
                        task.title = title
                        task.dateCreated = Date()
                        save()
                        title = ""
                    }
                
                List {
                    ForEach(taskSections) { taskSection in
                        Section {
                            ForEach(taskSection) { item in
                                HStack {
                                    Image(systemName: item.isCompleted ? "checkmark.square": "square")
                                        .onTapGesture {
                                            item.isCompleted.toggle()
                                            save()
                                        }
                                    Text(item.title ?? "")
                                }
                            }.onDelete { indexSet in
                                
                                let sections = Array(taskSection)
                                for index in indexSet {
                                    let task = sections[index]
                                    viewContext.delete(task)
                                }
                                
                                save()
                                
                            }
                        } header: {
                            Text(taskSection.id ? "Completed": "Pending")
                        }

                    }
                }.listStyle(.plain)
                
                
                
                .navigationTitle("Tasks")
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
