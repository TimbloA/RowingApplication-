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
    
    var existingCrew: Crew?
    var onSave: (Crew) -> Void
    
    init(crew: Crew? = nil, onSave: @escaping (Crew) -> Void) {
        self.existingCrew = crew
        self.onSave = onSave
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
                        // List showing all the selected athletes
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
                    .disabled(crewName.isEmpty) // Disabled if crew name is empty
                }
            }
        }
        .onAppear {
            if let existingCrew = existingCrew {
                crewName = existingCrew.name
                selectedAthletes = existingCrew.athletes
            }
        }
    }
    
    //save the crew
    private func saveCrew() {
        let crew = Crew(name: crewName, athletes: selectedAthletes)
        
        if let existingCrew = existingCrew {
            if let index = DataManager.shared.crews.firstIndex(where: { $0.id == existingCrew.id }) {
                DataManager.shared.crews[index] = crew
            }
        } else {
            DataManager.shared.crews.append(crew)
            DataManager.shared.saveData()
        }
        
        onSave(crew)
        dismiss() //remove the view after saving
    }
}
