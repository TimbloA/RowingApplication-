//
//  AthleteListView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 12/09/2024.
//

import SwiftUI

struct AthleteListView: View {
    @StateObject var athleteViewModel: AthletesViewModel = AthletesViewModel.shared
    @State private var searchText: String = ""
    @State private var selectedSide: athleteSide? = nil // State to hold the selected side
    
    var searchResults: [Athlete] {
        // Filter by side if one is selected, otherwise filter by search text or return all
        let filteredAthletes = selectedSide == nil
            ? DataManager.shared.athletes
            : DataManager.shared.athletes.filter { $0.side == selectedSide }
        
        if searchText.isEmpty {
            return filteredAthletes
        } else {
            return filteredAthletes.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        VStack {
            NavigationStack {
                VStack {
                    // Picker for athlete side filter
                    Picker("Select Side", selection: $selectedSide) {
                        Text("All").tag(athleteSide?.none) // Option for all sides
                        ForEach(athleteSide.allCases, id: \.self) { side in
                            Text(side.rawValue).tag(side as athleteSide?)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    List {
                        ForEach(searchResults, id: \.self.id) { athlete in
                            NavigationLink(destination: AthleteView(athlete: athlete)) {
                                Text("\(athlete.name)")
                            }
                        }
                        .onDelete(perform: deleteItems)
                        Button("Add New Athlete") {
                            athleteViewModel.newAthlete.toggle()
                        }
                    }
                    .navigationTitle("Athletes")
                    .sheet(isPresented: $athleteViewModel.newAthlete) {
                        NewAthleteView()
                            .presentationDetents([.medium, .large])
                    }
                }
            }
            .searchable(text: $searchText)
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        // Remove the selected athletes directly from DataManager
        DataManager.shared.athletes.remove(atOffsets: offsets)
        DataManager.shared.saveData() // Save the updated athletes data
    }
}

#Preview {
    AthleteListView()
}
