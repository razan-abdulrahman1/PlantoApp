//
//  ContentView.swift
//  PlantoApp
//
//  Created by Razan on 29/05/1448 AH.
//

import SwiftUI

struct ContentView: View {

    // State
    @State var viewModel = RemindersViewModel()
    @State var isShowingForm = false                       // true = add form is open
    @State var reminderToEdit: PlantReminder? = nil        // the plant being edited

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // Header
            Text("My Plants 🌱")
                .font(.largeTitle.bold())
                .padding(.horizontal, 16)
                .padding(.bottom, 8)

            Divider()

            // Content (one screen for each home state)
            Group {
                switch viewModel.homeState {
                case .welcome: WelcomeView(onSetReminder: { isShowingForm = true })
                case .empty: EmptyStateView()
                case .list: RemindersListView(viewModel: viewModel, onEdit: { reminder in
                    reminderToEdit = reminder
                })
                case .allDone: AllDoneView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }

        // Add Button (hidden on the welcome screen)
        .overlay(alignment: .bottomTrailing) {
            if viewModel.homeState != .welcome {
                Button("Add Reminder", systemImage: "plus") {
                    isShowingForm = true
                }
                .labelStyle(.iconOnly)
                .font(.title2)
                .buttonStyle(.glassProminent)
                .buttonBorderShape(.circle)
                .tint(.primaryGreen)
                .padding(24)
            }
        }

        // Add Sheet
        .sheet(isPresented: $isShowingForm) {
            ReminderFormView(viewModel: viewModel)
        }

        // Edit Sheet (opens when reminderToEdit has a plant)
        .sheet(item: $reminderToEdit) { reminder in
            ReminderFormView(viewModel: viewModel, reminderToEdit: reminder)
        }
    }
}

// Preview
#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
