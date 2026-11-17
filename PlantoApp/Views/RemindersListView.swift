//
//  RemindersListView.swift
//  PlantoApp
//

import SwiftUI

struct RemindersListView: View {
    let viewModel: RemindersViewModel
    var onEdit: (PlantReminder) -> Void

    var body: some View {
        VStack(spacing: 0) {

            ProgressHeader(message: viewModel.progressMessage, progress: viewModel.progress)

            List {
                ForEach(viewModel.reminders) { reminder in
                    ReminderRow(reminder: reminder, onToggle: {
                        viewModel.toggleDone(reminder)
                    })
                    .contentShape(Rectangle())          // Whole row is tappable
                    .onTapGesture {
                        onEdit(reminder)                // Tap row = edit
                    }
                    .listRowBackground(Color.clear)
                    .swipeActions {                     // Swipe left = delete
                        Button(role: .destructive) {
                            viewModel.delete(reminder)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    RemindersListView(viewModel: RemindersViewModel(), onEdit: { _ in })
        .preferredColorScheme(.dark)
}
