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

    func add(_ reminder: PlantReminder) {
        reminders.append(reminder)
    }
}
