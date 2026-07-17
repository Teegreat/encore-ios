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
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                MainTabView()
            } else {
                OnboardingView()
            }
       
        }
        .modelContainer(for: Show.self)
    }
}

