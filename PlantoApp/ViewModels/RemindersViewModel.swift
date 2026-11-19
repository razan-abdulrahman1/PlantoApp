//
//  RemindersViewModel.swift
//  PlantoApp
//
//  Created by Razan on 02/06/1448 AH.
//

import Foundation
import Observation

// Which screen the home page shows
enum HomeState {
    case welcome
    case empty
    case list
    case allDone
}

@Observable
class RemindersViewModel {

    // Data
    // Save the list every time it changes
    var reminders: [PlantReminder] = [] {
        didSet { save() }
    }

    // Save it every time it changes
    var hasAddedBefore = false {
        didSet { UserDefaults.standard.set(hasAddedBefore, forKey: "hasAddedBefore") }
    }

    // Load the saved data when the app opens
    init() {
        hasAddedBefore = UserDefaults.standard.bool(forKey: "hasAddedBefore")

        if let data = UserDefaults.standard.data(forKey: "reminders") {
            if let saved = try? JSONDecoder().decode([PlantReminder].self, from: data) {
                reminders = saved
            }
        }
    }

    // Saving
    // Turn the list into data and save it
    func save() {
        if let data = try? JSONEncoder().encode(reminders) {
            UserDefaults.standard.set(data, forKey: "reminders")
        }
    }

    // Helper
    // Find where this plant is in the list
    private func findIndex(of reminder: PlantReminder) -> Int? {
        return reminders.firstIndex(where: { item in item.id == reminder.id })
    }

    // Home State
    // Decides which screen ContentView shows
    var homeState: HomeState {
        if reminders.isEmpty {
            return hasAddedBefore ? .empty : .welcome
        }
        if doneCount == reminders.count {
            return .allDone
        }
        return .list
    }

    // Progress
    // How many plants are watered
    var doneCount: Int {
        var count = 0
        for reminder in reminders {
            if reminder.isDone {
                count += 1
            }
        }
        return count
    }

    // From 0 (none) to 1 (all), used by the progress bar
    var progress: Double {
        if reminders.isEmpty { return 0 }
        return Double(doneCount) / Double(reminders.count)
    }

    // The text above the progress bar
    var progressMessage: String {
        if doneCount == 0 {
            return "Your plants are waiting for a sip 💦"
        }
        return "\(doneCount) of your plants feel loved today ✨"
    }

    // Actions
    // Add a new plant and schedule its reminder
    func add(_ reminder: PlantReminder) {
        reminders.append(reminder)
        hasAddedBefore = true
        NotificationManager.requestPermission()              // ask when it's needed
        NotificationManager.schedule(for: reminder)
    }

    // Replace the plant with its edited version
    func update(_ reminder: PlantReminder) {
        if let index = findIndex(of: reminder) {
            reminders[index] = reminder
            NotificationManager.cancel(for: reminder)        // remove the old schedule
            NotificationManager.schedule(for: reminder)      // add the new schedule
        }
    }

    // Remove the plant and its reminder
    func delete(_ reminder: PlantReminder) {
        reminders.removeAll(where: { item in item.id == reminder.id })
        NotificationManager.cancel(for: reminder)
    }

    // Tap the circle: water the plant, or undo
    func toggleDone(_ reminder: PlantReminder) {
        if let index = findIndex(of: reminder) {
            if reminders[index].isDone {
                reminders[index].lastWateredDate = nil      // Undo
            } else {
                reminders[index].lastWateredDate = Date()   // Watered now
                NotificationManager.cancel(for: reminder)
                NotificationManager.schedule(for: reminders[index])    // next one from today
            }
        }
    }
}
