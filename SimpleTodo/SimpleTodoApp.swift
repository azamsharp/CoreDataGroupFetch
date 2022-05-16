//
//  SimpleTodoApp.swift
//  SimpleTodo
//
//  Created by Mohammad Azam on 5/16/22.
//

import SwiftUI

@main
struct SimpleTodoApp: App {
    var body: some Scene {
        WindowGroup {
            let _ = UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
            let coreDM = CoreDataManager.shared
            ContentView().environment(\.managedObjectContext, coreDM.viewContext)
        }
    }
}
