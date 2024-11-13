//
//  AthleteSelectionView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 18/10/2024.
//

import SwiftUI

struct AthleteSelectionView: View {
    @Binding var selectedAthletes: [Athlete] // Bound list of selected athletes
    @State private var searchText: String = ""
    @State private var selectedSide: athleteSide? = nil // State to hold the selected side
    @State private var showNewAthleteView = false // State to show the new athlete view

    var searchResults: [Athlete] {
        // Filter athletes by selected side and search text from DataManager
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
            // Picker to filter athletes by side (Bow or Stroke)
            Picker("Select Side", selection: $selectedSide) {
                Text("All").tag(nil as athleteSide?) // Show all athletes
                ForEach(athleteSide.allCases, id: \.self) { side in
                    Text(side.rawValue).tag(side as athleteSide?)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            List {
                ForEach(searchResults, id: \.self.id) { athlete in
                    AthleteRow(athlete: athlete, isSelected: selectedAthletes.contains(athlete)) {
                        toggleSelection(for: athlete)
                    }
                }
            }

            Button(action: {
                showNewAthleteView.toggle()
            }) {
                Text("Add New Athlete")
                    .padding()
                    .foregroundColor(.blue)
            }
            .sheet(isPresented: $showNewAthleteView) {
                NewAthleteView()
            }
        }
        .navigationTitle("Select Athletes")
        .searchable(text: $searchText) // Search bar
    }

    private func toggleSelection(for athlete: Athlete) {
        if let index = selectedAthletes.firstIndex(of: athlete) {
            selectedAthletes.remove(at: index)
        } else {
            selectedAthletes.append(athlete)
        }
    }

    
}

struct AthleteRow: View {
    var athlete: Athlete
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        HStack {
            Text(athlete.name)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            action() // Trigger selection or deselection
        }
    }
}


//#Preview {    )
//}
//
