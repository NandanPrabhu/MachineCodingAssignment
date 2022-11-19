//
//  MachineCodingAssignmentApp.swift
//  MachineCodingAssignment
//
//  Created by Nandan Prabhu on 19/11/22.
//

import SwiftUI

@main
struct MachineCodingAssignmentApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
