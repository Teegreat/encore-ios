//
//  OnboardingNotificationsPage.swift
//  Encore
//
//  Created by Toyin on 17/07/2026.
//

import SwiftUI
import UserNotifications

struct OnboardingNotificationsPage: View {
    @Binding var notificationsRequested: Bool
    var body: some View {
            
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: "bell.circle.fill")
                .font(.system(size: 90))
                .foregroundColor(.orange)
            Text("Show Reminders")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            Text("Get notified before upcoming shows so you're always prepared")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            
            if notificationsRequested{
                Label("You're all set!",
                systemImage: "checkmark.circle.fill")
                .foregroundStyle(.green)
                .font(.headline)
            } else {
                Button("Enable Notifications"){
                    UNUserNotificationCenter
                        .current()
                        .requestAuthorization(options: [.alert, .sound, .badge]) {
                            granted, _ in
                            
                            DispatchQueue.main.async {
                                notificationsRequested = true
                            }
                        }
                }
                .buttonStyle(.borderedProminent)
            }
            
            Spacer()
            Spacer()
                
        }
    }
}

//#Preview {
//    OnboardingNotificationsPage()
//}
