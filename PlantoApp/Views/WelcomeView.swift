//
//  WelcomeView.swift
//  PlantoApp
//
//  Created by Razan on 29/05/1448 AH.
//


import SwiftUI

struct WelcomeView: View {
    var onSetReminder: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Image(.illustrationWelcome)
                .resizable()
                .scaledToFit()
                .frame(width: 164)
                .accessibilityHidden(true) // Decorative, skip for VoiceOver

            Text("Start your plant journey!")
                .font(.title3.bold())

            Text("Now all your plants will be in one place and we will help you take care of them :) 🪴")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Button {
                onSetReminder()
            } label: {
                Text("Set Plant Reminder")
                    .frame(maxWidth: 280)
            }
            .buttonStyle(.glassProminent)
            .tint(.primaryGreen)
            .controlSize(.large)
            .padding(.top, 48)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    WelcomeView(onSetReminder: { })
        .preferredColorScheme(.dark) 
}
