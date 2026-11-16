//
//  EmptyStateView.swift
//  PlantoApp
//
//  Created by Razan on 29/05/1448 AH.
//
import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        Text("No reminders set yet..")
            .font(.headline)
            .foregroundStyle(.secondary)
    }
}

#Preview {
    EmptyStateView()
        .preferredColorScheme(.dark)
}
