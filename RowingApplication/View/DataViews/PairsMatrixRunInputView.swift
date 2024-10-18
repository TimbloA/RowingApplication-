//
//  PairsMatrixRunInputView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 10/10/2024.
//
//
//  PairsMatrixRunInputView.swift
//  RowingApplication

import SwiftUI

struct PairsMatrixRunInputView: View {
    @Binding var wavesData: [[PairsCrewInput]]
    @State private var searchBowText: String = ""
    @State private var searchStrokeText: String = ""

    @FocusState private var bowFieldFocused: Bool // Manage focus state for Bow Name
    @FocusState private var strokeFieldFocused: Bool // Manage focus state for Stroke Name

    // Variables to hold the selected athletes passed from the parent view
    var selectedBowSideAthletes: [Athlete]
    var selectedStrokeSideAthletes: [Athlete]

    var body: some View {
        ScrollView {
            ForEach(0..<wavesData.count, id: \.self) { waveIndex in
                VStack(alignment: .leading) {
                    Text("Wave \(waveIndex + 1)").font(.headline).padding(.top)
                    ForEach(0..<wavesData[waveIndex].count, id: \.self) { crewIndex in
                        VStack(alignment: .leading) {
                            Text("Crew \(crewIndex + 1)")

                            // Autocomplete for Bow Name
                            TextField("Bow Name", text: $wavesData[waveIndex][crewIndex].bowName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .focused($bowFieldFocused)
                                .onChange(of: wavesData[waveIndex][crewIndex].bowName) { newValue in
                                    searchBowText = newValue // Update search text
                                }
                                .onSubmit {
                                    bowFieldFocused = false // Dismiss keyboard on submit
                                    searchBowText = "" // Clear search text on submit
                                }

                            // Suggestions for Bow Names
                            AthleteAutocompleteView(
                                searchText: $searchBowText,
                                filteredAthletes: filteredBowAthletes
                            ) { selectedAthlete in
                                wavesData[waveIndex][crewIndex].bowName = selectedAthlete.name // Assign athlete's name to TextField
                                searchBowText = "" // Clear search text
                                bowFieldFocused = false // Dismiss keyboard
                            }

                            // Autocomplete for Stroke Name
                            TextField("Stroke Name", text: $wavesData[waveIndex][crewIndex].strokeName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .focused($strokeFieldFocused)
                                .onChange(of: wavesData[waveIndex][crewIndex].strokeName) { newValue in
                                    searchStrokeText = newValue // Update search text
                                }
                                .onSubmit {
                                    strokeFieldFocused = false // Dismiss keyboard on submit
                                    searchStrokeText = "" // Clear search text on submit
                                }

                            // Suggestions for Stroke Names
                            AthleteAutocompleteView(
                                searchText: $searchStrokeText,
                                filteredAthletes: filteredStrokeAthletes
                            ) { selectedAthlete in
                                wavesData[waveIndex][crewIndex].strokeName = selectedAthlete.name // Assign athlete's name to TextField
                                searchStrokeText = "" // Clear search text
                                strokeFieldFocused = false // Dismiss keyboard
                            }

                            Text("Start Time")
                            TimeInputView(timeTenths: $wavesData[waveIndex][crewIndex].startTime)
                            Text("Finish Time")
                            TimeInputView(timeTenths: $wavesData[waveIndex][crewIndex].finishTime)
                        }
                        .padding(.bottom)
                    }
                }
            }
        }
        .padding()
        .onTapGesture {
            // Dismiss keyboard when tapping outside of the text fields
            bowFieldFocused = false
            strokeFieldFocused = false
            searchBowText = "" // Clear the search text when tapping outside
            searchStrokeText = "" // Clear the search text when tapping outside
        }
    }

    // Filtered list for bow-side athletes
    private var filteredBowAthletes: [Athlete] {
        selectedBowSideAthletes.filter { athlete in
            athlete.name.lowercased().contains(searchBowText.lowercased())
        }
    }

    // Filtered list for stroke-side athletes
    private var filteredStrokeAthletes: [Athlete] {
        selectedStrokeSideAthletes.filter { athlete in
            athlete.name.lowercased().contains(searchStrokeText.lowercased())
        }
    }
}

//#Preview {
//    PairsMatrixRunInputView(wavesData: <#Binding<[[PairsCrewInput]]>#>)
//}
