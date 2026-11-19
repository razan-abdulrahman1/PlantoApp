//
//  PlantReminder.swift
//  PlantoApp
//
//  Created by Razan on 02/06/1448 AH.
//

import Foundation

struct PlantReminder: Identifiable, Codable {
    var id = UUID()                             
    var name: String
    var room: Room
    var light: Light
    var wateringFrequency: WateringFrequency
    var waterAmount: WaterAmount
    var lastWateredDate: Date? = nil

    // Is the plant watered for now? (based on its own schedule)
    var isDone: Bool {
        if let lastWateredDate = lastWateredDate {
            // Count the days since the last watering
            let calendar = Calendar.current
            let wateredDay = calendar.startOfDay(for: lastWateredDate)
            let today = calendar.startOfDay(for: Date())
            
            // the gap between the two days
            let difference = calendar.dateComponents([.day], from: wateredDay, to: today)

            // the number of days in that gap
            let daysPassed = difference.day ?? 0

            // Done while the next watering day hasn't come yet
            return daysPassed < wateringFrequency.days
        }

        // Never watered = not done
        return false
    }
}
