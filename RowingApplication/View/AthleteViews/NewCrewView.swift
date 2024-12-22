//
//  NewCrewView.swift
//  RowingApplication
//
//  Created by Adi Timblo on 22/12/2024.
//

import SwiftUI

struct NewCrewView: View {
    @Environment(\.dismiss) var dismiss

    @State private var crewName = ""
    @State private var selectedAthletes: [Athlete] = []

    // Editing an existing crew
    var existingCrew: Crew?

    init(crew: Crew? = nil) {
        if let crew = crew {
            _crewName = State(initialValue: crew.name)
            _selectedAthletes = State(initialValue: crew.athletes)
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Crew Details")) {
                    TextField("Crew Name", text: $crewName)
                }

                Section(header: Text("Selected Athletes")) {
                    if selectedAthletes.isEmpty {
                        Text("No athletes selected")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(selectedAthletes) { athlete in
                            AthleteRow(athlete: athlete, isSelected: true) {
                                if let index = selectedAthletes.firstIndex(of: athlete) {
                                    selectedAthletes.remove(at: index)
                                }
                            }
                        }
                    }

                    NavigationLink {
                        AthleteSelectionView(selectedAthletes: $selectedAthletes)
                    } label: {
                        Label("Select Athletes", systemImage: "person.2.badge.plus")
                    }
                }
            }
            .navigationTitle(existingCrew != nil ? "Edit Crew" : "New Crew")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveCrew()
                    }
                    .disabled(crewName.isEmpty) // Disable if crew name is empty
                }
            }
        }
    }

    private func saveCrew() {
        let crew = Crew(name: crewName, athletes: selectedAthletes)

        if let existingCrew = existingCrew {
            // If editing an existing crew, find its index and replace it in the array
            if let index = DataManager.shared.crews.firstIndex(where: { $0.id == existingCrew.id }) {
                DataManager.shared.crews[index] = crew
            }
        } else {
            // If creating a new crew, append it to the shared list
            DataManager.shared.crews.append(crew)
        }

        dismiss() // Dismiss the view after saving
    }
}





