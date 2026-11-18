//
//  ReminderRow.swift
//  PlantoApp
//

import SwiftUI

struct ReminderRow: View {
    let reminder: PlantReminder
    var onToggle: () -> Void

    var body: some View {
        HStack(spacing: 12) {

            // Check circle
            Button {
                onToggle()
            } label: {
                Image(systemName: reminder.isDone ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(reminder.isDone ? Color.accentMint : Color.secondary)
            }
            .buttonStyle(.borderless)

            // Plant info
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 4) {
                    Image(systemName: "location")
                    Text("in \(reminder.room.rawValue)")
                }
                .font(.caption)
                .foregroundStyle(.secondary)

                Text(reminder.name)
                    .font(.title2)
                    .foregroundStyle(reminder.isDone ? Color.secondary : Color.primary)

                HStack {
                    InfoChip(icon: reminder.light.icon, text: reminder.light.rawValue, color: .chipSunlight)
                    InfoChip(icon: "drop", text: reminder.waterAmount.rawValue, color: .chipWater)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ReminderRow(
        reminder: PlantReminder(name: "Monstera", room: .kitchen, light: .fullSun,
                                wateringFrequency: .everyDay, waterAmount: .ml20to50),
        onToggle: { }
    )
    .preferredColorScheme(.dark)
}
