//
//  RemindersViewModel.swift
//  PlantoApp
//
//  Created by Razan on 02/06/1448 AH.
//

import Foundation
import Observation

@Observable
class RemindersViewModel {
    var reminders: [PlantReminder] = []
    var hasAddedBefore = false

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
    func add(_ reminder: PlantReminder) {
        reminders.append(reminder)
        hasAddedBefore = true
        NotificationManager.requestPermission()              // ask when it's needed
        NotificationManager.schedule(for: reminder)
    }

    func update(_ reminder: PlantReminder) {
        if let index = reminders.firstIndex(where: { item in item.id == reminder.id }) {
            reminders[index] = reminder
            NotificationManager.cancel(for: reminder)        // remove the old schedule
            NotificationManager.schedule(for: reminder)      // add the new schedule
        }
    }

    func delete(_ reminder: PlantReminder) {
        reminders.removeAll(where: { item in item.id == reminder.id })
        NotificationManager.cancel(for: reminder)
    }

    func toggleDone(_ reminder: PlantReminder) {
        if let index = reminders.firstIndex(where: { item in item.id == reminder.id }) {
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
