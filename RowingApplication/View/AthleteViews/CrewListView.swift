//
//  CrewListView.swift
//  RowingApplication
//
//  Created by Adi Timblo on 22/12/2024.
//
import SwiftUI
struct CrewListView: View {
    @ObservedObject var dataManager = DataManager.shared

    @State private var showingCrewForm = false
    @State private var selectedCrew: Crew?

    var body: some View {
        NavigationView {
            List {
                // List of all crews
                ForEach(dataManager.crews) { crew in
                    CrewRowView(crew: crew)
                        .onTapGesture {
                            selectedCrew = crew  // choose the selected crew to edit
                        }
                }
                .onDelete(perform: deleteCrew)
            }
            .navigationTitle("Crews")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Crew") {
                        showingCrewForm = true
                    }
                }
            }
            .sheet(isPresented: $showingCrewForm) {
                NewCrewView(onSave: { newCrew in
                })
            }
            .sheet(item: $selectedCrew) { crew in
                NewCrewView(crew: crew, onSave: { updatedCrew in
                    // This will update the crew when edited
                    if let index = dataManager.crews.firstIndex(where: { $0.id == crew.id }) {
                        dataManager.crews[index] = updatedCrew
                    }
                })
            }
        }
    }


    private func deleteCrew(at offsets: IndexSet) {
        dataManager.crews.remove(atOffsets: offsets)
    }
}
