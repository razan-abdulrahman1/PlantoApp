//
//  ReminderFormView.swift
//  PlantoApp
//
//  Created by Razan on 29/05/1448 AH.
//
import SwiftUI

struct ReminderFormView: View {
    let viewModel: RemindersViewModel
    var reminderToEdit: PlantReminder? = nil   // NEW: nil = add, has value = edit
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

                // Delete (edit mode only)
                if reminderToEdit != nil {
                    Section {
                        Button("Delete Reminder", role: .destructive) {
                            deleteReminder()
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .tint(.primary)
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
                        saveReminder()
                    }
                    .tint(.primaryGreen)
                    .disabled(plantName.isEmpty)             // can't save without a name
                }
            }
            .onAppear {
                fillFields()
            }
        }
    }

    // Actions 

    // In edit mode, show the plant's saved values
    private func fillFields() {
        if let reminder = reminderToEdit {
            plantName = reminder.name
            room = reminder.room
            light = reminder.light
            wateringFrequency = reminder.wateringFrequency
            waterAmount = reminder.waterAmount
        }
    }

    // Add a new plant, or update the edited one
    private func saveReminder() {
        if let reminder = reminderToEdit {
            var updatedReminder = reminder
            updatedReminder.name = plantName
            updatedReminder.room = room
            updatedReminder.light = light
            updatedReminder.wateringFrequency = wateringFrequency
            updatedReminder.waterAmount = waterAmount
            viewModel.update(updatedReminder)
        } else {
            let newPlant = PlantReminder(
                name: plantName,
                room: room,
                light: light,
                wateringFrequency: wateringFrequency,
                waterAmount: waterAmount
            )
            viewModel.add(newPlant)
        }
        dismiss()
    }

    // Delete the edited plant
    private func deleteReminder() {
        if let reminder = reminderToEdit {
            viewModel.delete(reminder)
        }
        dismiss()
    }
}

// Shown as a sheet, like in the app
#Preview {
    Color.black
        .sheet(isPresented: .constant(true)) {
            ReminderFormView(viewModel: RemindersViewModel())
        }
        .preferredColorScheme(.dark)
}
