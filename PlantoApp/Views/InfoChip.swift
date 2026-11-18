//
//  InfoChip.swift
//  PlantoApp
//
//  Created by Razan on 02/06/1448 AH.
//

import SwiftUI

struct InfoChip: View {
    let icon: String
    let text: String
    let color: Color

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
            Text(text)
        }
        .font(.caption)
        .foregroundStyle(color)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(.chipBackground, in: RoundedRectangle(cornerRadius: 6))
    }
}

#Preview {
    HStack {
        InfoChip(icon: "sun.max", text: "Full sun", color: .chipSunlight)
        InfoChip(icon: "drop", text: "20-50 ml", color: .chipWater)
    }
    .preferredColorScheme(.dark)
}
