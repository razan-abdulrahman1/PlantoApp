//
//  PlantReminder.swift
//  PlantoApp
//
//  Created by Razan on 02/06/1448 AH.
//

import Foundation

struct PlantReminder: Identifiable {
    let id = UUID()
    var name: String
    var room: Room
    var light: Light
    var wateringFrequency: WateringFrequency
    var waterAmount: WaterAmount
    var lastWateredDate: Date? = nil
}
