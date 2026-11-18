//
//  ReminderOptions.swift
//  PlantoApp
//
//  Created by Razan on 29/05/1448 AH.
//
import Foundation

// Room
enum Room: String, CaseIterable, Identifiable, Codable {
    case bedroom = "Bedroom"
    case livingRoom = "Living Room"
    case kitchen = "Kitchen"
    case balcony = "Balcony"
    case bathroom = "Bathroom"

    var id: Self { self }
}

// Light
enum Light: String, CaseIterable, Identifiable, Codable {
    case fullSun = "Full sun"
    case partialSun = "Partial sun"
    case lowLight = "Low light"

    var id: Self { self }

    // SF Symbol for each light level (matches the design)
    var icon: String {
        switch self {
        case .fullSun: "sun.max"
        case .partialSun: "sun.haze"
        case .lowLight: "moon"
        }
    }
}

// Watering Frequency
enum WateringFrequency: String, CaseIterable, Identifiable, Codable {
    case everyDay = "Every day"
    case every2Days = "Every 2 days"
    case every3Days = "Every 3 days"
    case onceAWeek = "Once a week"
    case every10Days = "Every 10 days"
    case every2Weeks = "Every 2 weeks"

    var id: Self { self }

    // Number of days between waterings
    var days: Int {
        switch self {
        case .everyDay: 1
        case .every2Days: 2
        case .every3Days: 3
        case .onceAWeek: 7
        case .every10Days: 10
        case .every2Weeks: 14
        }
    }
}

// Water Amount
enum WaterAmount: String, CaseIterable, Identifiable, Codable {
    case ml20to50 = "20-50 ml"
    case ml50to100 = "50-100 ml"
    case ml100to200 = "100-200 ml"
    case ml200to300 = "200-300 ml"

    var id: Self { self }
}
