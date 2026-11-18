//
//  AllDoneView.swift
//  PlantoApp
//
//  Created by Razan on 29/05/1448 AH.
//
import SwiftUI

struct AllDoneView: View {
    var body: some View {
        VStack(spacing: 16) {

            // Illustration
            Image(.illustrationAllDone)
                .resizable()
                .scaledToFit()
                .frame(width: 164)
                .padding(24) // Space between the plant and the circle edge
                .background(.illustrationBackground, in: Circle()) // the color already has 58% opacity
                .accessibilityHidden(true)

            // Title
            Text("All Done! 🎉")
                .font(.title3.bold())

            // Subtitle
            Text("All Reminders Completed")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    AllDoneView()
        .preferredColorScheme(.dark)
}
