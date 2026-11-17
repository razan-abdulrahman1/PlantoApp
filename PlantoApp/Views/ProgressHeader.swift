//
//  ProgressHeader.swift
//  PlantoApp
//

import SwiftUI

struct ProgressHeader: View {
    let message: String
    let progress: Double

    var body: some View {
        VStack(spacing: 12) {
            Text(message)
                .font(.subheadline)

            ProgressView(value: progress)
                .tint(.accentMint)
                .animation(.easeInOut, value: progress)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
    }
}

#Preview {
    ProgressHeader(message: "3 of your plants feel loved today ✨", progress: 0.75)
        .preferredColorScheme(.dark)
}

