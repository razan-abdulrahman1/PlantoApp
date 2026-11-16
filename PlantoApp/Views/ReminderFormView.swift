//
//  ReminderFormView.swift
//  PlantoApp
//
//  Created by Razan on 29/05/1448 AH.
//
import SwiftUI

struct ReminderFormView: View {
    let viewModel: RemindersViewModel
    @Environment(\.dismiss) private var dismiss

    // Form Fields 
    @State private var plantName = ""
    @State private var room: Room = .bedroom
    @State private var light: Light = .fullSun
    @State private var wateringFrequency: WateringFrequency = .everyDay
    @State private var waterAmount: WaterAmount = .ml20to50

    var body: some View {
        NavigationStack {
            Form {

                // Plant Name
                Section {
                    HStack {
                        Text("Plant Name")
                        TextField("Pothos", text: $plantName)
                            .tint(.accentMint)
                    }
                }

                // Room & Light
                Section {
                    Picker(selection: $room) {
                        ForEach(Room.allCases) { room in
                            Text(room.rawValue).tag(room)
                        }
                    } label: {
                        Label("Room", systemImage: "location")
                    }

                    Picker(selection: $light) {
                        ForEach(Light.allCases) { light in
                            Text(light.rawValue).tag(light)
                        }
                    } label: {
                        Label("Light", systemImage: "sun.max")
                    }
                }

                // Watering Days & Water
                Section {
                    Picker(selection: $wateringFrequency) {
                        ForEach(WateringFrequency.allCases) { frequency in
                            Text(frequency.rawValue).tag(frequency)
                        }
                    } label: {
                        Label("Watering Days", systemImage: "drop")
                    }

                    Picker(selection: $waterAmount) {
                        ForEach(WaterAmount.allCases) { amount in
                            Text(amount.rawValue).tag(amount)
                        }
                    } label: {
                        Label("Water", systemImage: "drop")
                    }
                }
            }
            .tint(.primary) // White icons, like the design
            
            .navigationTitle("Set Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "xmark") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", systemImage: "checkmark") {
                        let newPlant = PlantReminder(
                            name: plantName,
                            room: room,
                            light: light,
                            wateringFrequency: wateringFrequency,
                            waterAmount: waterAmount
                        )
                        viewModel.add(newPlant)
                        dismiss()
                    }
                    .tint(.primaryGreen)
                }
            }
        }
    }
}

#Preview {
    ReminderFormView(viewModel: RemindersViewModel())
        .preferredColorScheme(.dark)
}
