//
//  NotificationManager.swift
//  PlantoApp
//

import UserNotifications

enum NotificationManager {

    // Ask the user to allow notifications
    static func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in }
    }

    // Schedule a reminder at 9 AM on the plant's next watering day
    static func schedule(for reminder: PlantReminder) {
        let content = UNMutableNotificationContent()
        content.body = "Hey! let's water your plant"
        content.sound = .default

        // Start from the last watering, or from today for a new plant
        let startDate = reminder.lastWateredDate ?? Date()

        // Add the plant's watering days
        let calendar = Calendar.current
        let nextWateringDay = calendar.date(byAdding: .day, value: reminder.wateringFrequency.days, to: startDate) ?? startDate

        // Set the time to 9:00 AM on that day
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: nextWateringDay)
        dateComponents.hour = 9
        dateComponents.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        let request = UNNotificationRequest(
            identifier: reminder.id.uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }

    // Stop the reminder of a deleted or edited plant
    static func cancel(for reminder: PlantReminder) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [reminder.id.uuidString])
    }
}
