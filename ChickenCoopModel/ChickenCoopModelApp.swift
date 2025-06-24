//
//  ChickenCoopModelApp.swift
//  ChickenCoopModel
//
//  Created by Furkan İSLAM on 24.06.2025.
//

import SwiftUI
import SwiftData

@main
struct ChickenCoopModelApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Pet.self)
        }
    }
}
