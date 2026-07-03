//
//  EncoreApp.swift
//  Encore
//
//  Created by Toyin on 03/07/2026.
//

import SwiftUI
import SwiftData

@main
struct EncoreApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(for: Show.self)
    }
}

