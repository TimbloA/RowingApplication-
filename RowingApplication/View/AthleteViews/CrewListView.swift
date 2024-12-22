//
//  CrewListView.swift
//  RowingApplication
//
//  Created by Adi Timblo on 22/12/2024.
//

import SwiftUI

struct CrewListView: View {
    @ObservedObject var dataManager = DataManager.shared  // Observing shared DataManager
    
    @State private var showingCrewForm = false
    @State private var selectedCrew: Crew?

    var body: some View {
        NavigationView {
            List {
                ForEach(dataManager.crews) { crew in
                    CrewRowView(crew: crew)
                        .onTapGesture {
                            selectedCrew = crew
                        }
                }
                .onDelete(perform: deleteCrew)
            }
            .navigationTitle("Crews")
            .toolbar {
                Button("Add Crew") {
                    showingCrewForm = true
                }
            }
            .sheet(isPresented: $showingCrewForm) {
                NewCrewView() // No need for closure anymore, crew is directly handled in NewCrewView
            }
            .sheet(item: $selectedCrew) { crew in
                NewCrewView(crew: crew) // Editing existing crew
            }
        }
    }

    private func deleteCrew(at offsets: IndexSet) {
        dataManager.crews.remove(atOffsets: offsets)  // Deleting from shared crews
    }
}

#Preview {
    CrewListView()
}
