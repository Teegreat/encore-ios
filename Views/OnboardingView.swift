//
//  OnboardingView.swift
//  Encore
//
//  Created by Toyin on 17/07/2026.
//

import SwiftUI
import UserNotifications

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    @State private var currentPage = 0
    @State private var notificationsRequested = false
    
    private let pages: [(icon: String, color: Color, title: String, description: String)] = [
        ("ticket.fill", .purple, "Your Concert History", "Log every show you've been to. Build a record of your live music journey"),
        ("music.microphone.circle.fill", .pink, "Every detail captured", "Set lists, ratings, notes - everything that made each night unforgettable"),
        ("calendar", .blue, "Never miss a show", "save upcoming concert and keep track of what is on your rader")
        
    ]
    private var isLastPage: Bool { currentPage == pages.count }
    
    private func advance() {
        if isLastPage {
            hasCompletedOnboarding = true
        } else {
            withAnimation {
                currentPage += 1
            }
        }
    }
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(pages.indices, id: \.self) { index in
                    OnboardingIntroPageView(
                        icon: pages[index].icon,
                        color: pages[index].color,
                        title: pages[index].title,
                        description: pages[index].description
                    )
                    .tag(index)
                }
                OnboardingNotificationsStepView(notificationsRequested: $notificationsRequested)
                    .tag(pages.count)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .animation(.easeInOut, value: currentPage)
            
            Button(action: advance) {
                Text(isLastPage ? "Let's go" : "Continue")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding(.horizontal)
            .padding(.bottom, 32)
        }
    }
}

private struct OnboardingIntroPageView: View {
    let icon: String
    let color: Color
    let title: String
    let description: String

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: icon)
                .font(.system(size: 64))
                .foregroundStyle(color)
            Text(title)
                .font(.title)
                .bold()
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

private struct OnboardingNotificationsStepView: View {
    @Binding var notificationsRequested: Bool

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "bell.badge.fill")
                .font(.system(size: 56))
                .foregroundStyle(.orange)
            Text("Stay in the loop")
                .font(.title2)
                .bold()
            Text("Enable notifications so we can remind you about upcoming shows.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            Button(notificationsRequested ? "Notifications Enabled" : "Enable Notifications") {
                requestNotifications()
            }
            .buttonStyle(.borderedProminent)
            .disabled(notificationsRequested)
        }
        .padding()
    }

    private func requestNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            DispatchQueue.main.async {
                notificationsRequested = granted
            }
        }
    }
}

#Preview {
    OnboardingView()
}
