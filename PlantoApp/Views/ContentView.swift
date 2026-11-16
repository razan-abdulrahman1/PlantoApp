//
//  ContentView.swift
//  PlantoApp
//
//  Created by Razan on 29/05/1448 AH.
//
import SwiftUI

//Home States
enum HomeState {
    case welcome
    case empty
    case list
    case allDone
}

struct ContentView: View {
    @State var state: HomeState = .welcome // Temporary: the ViewModel will decide this later
    @State var isShowingForm = false
    @State var viewModel = RemindersViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // Header
            Text("My Plants 🌱")
                .font(.largeTitle.bold())
                .padding(.horizontal, 16)
                .padding(.bottom, 8)

            Divider()

            // Content
            Group {
                switch state {
                case .welcome: WelcomeView(onSetReminder: { isShowingForm = true })
                case .empty: EmptyStateView()
                case .list: Text("\(viewModel.reminders.count) plants") // Temporary placeholder
                case .allDone: AllDoneView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        // Add Button
        .overlay(alignment: .bottomTrailing) {
            if state != .welcome {
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
        // Set Reminder Sheet
        .sheet(isPresented: $isShowingForm) {
            ReminderFormView(viewModel: viewModel)
        }
    }
    }


// Previews
#Preview("Welcome") {
    ContentView(state: .welcome)
        .preferredColorScheme(.dark)
}

#Preview("Empty") {
    ContentView(state: .empty)
        .preferredColorScheme(.dark)
}

#Preview("List") {
    ContentView(state: .list)
        .preferredColorScheme(.dark)
}

#Preview("All Done") {
    ContentView(state: .allDone)
        .preferredColorScheme(.dark)
}
