//
//  PairsMatrixRunInputView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 10/10/2024.
//

import SwiftUI

struct PairsMatrixRunInputView: View {
    @Binding var wavesData: [[PairsCrewInput]]

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

                            TextField("Bow Name", text: $wavesData[waveIndex][crewIndex].bowName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .focused($bowFieldFocused)
                                .onChange(of: wavesData[waveIndex][crewIndex].bowName) { newValue in
                                    wavesData[waveIndex][crewIndex].searchBowText = newValue
                                }
                                .onSubmit {
                                    bowFieldFocused = false
                                    wavesData[waveIndex][crewIndex].searchBowText = ""
                                }

                            // Suggestions for Bow Names
                            AthleteAutocompleteView(
                                searchText: $wavesData[waveIndex][crewIndex].searchBowText,
                                filteredAthletes: filteredBowAthletes(for: waveIndex, crewIndex: crewIndex)
                            ) { selectedAthlete in
                                wavesData[waveIndex][crewIndex].bowName = selectedAthlete.name
                                wavesData[waveIndex][crewIndex].searchBowText = "" /
                                bowFieldFocused = false 
                            }

                            TextField("Stroke Name", text: $wavesData[waveIndex][crewIndex].strokeName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .focused($strokeFieldFocused)
                                .onChange(of: wavesData[waveIndex][crewIndex].strokeName) { newValue in
                                    wavesData[waveIndex][crewIndex].searchStrokeText = newValue
                                }
                                .onSubmit {
                                    strokeFieldFocused = false
                                    wavesData[waveIndex][crewIndex].searchStrokeText = ""
                                }

                            AthleteAutocompleteView(
                                searchText: $wavesData[waveIndex][crewIndex].searchStrokeText,
                                filteredAthletes: filteredStrokeAthletes(for: waveIndex, crewIndex: crewIndex)
                            ) { selectedAthlete in
                                wavesData[waveIndex][crewIndex].strokeName = selectedAthlete.name
                                wavesData[waveIndex][crewIndex].searchStrokeText = ""
                                strokeFieldFocused = false
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
            // Dismiss keyboard and clear search text when tapping outside of the text fields
            bowFieldFocused = false
            strokeFieldFocused = false
            
            // Hide suggestions
            for waveIndex in wavesData.indices {
                for crewIndex in wavesData[waveIndex].indices {
                    wavesData[waveIndex][crewIndex].searchBowText = ""
                    wavesData[waveIndex][crewIndex].searchStrokeText = ""
                }
            }
        }
    }

    // Filtered list for bow-side athletes
    private func filteredBowAthletes(for waveIndex: Int, crewIndex: Int) -> [Athlete] {
        selectedBowSideAthletes.filter { athlete in
            athlete.name.lowercased().contains(wavesData[waveIndex][crewIndex].searchBowText.lowercased())
        }
    }

    // Filtered list for stroke-side athletes
    private func filteredStrokeAthletes(for waveIndex: Int, crewIndex: Int) -> [Athlete] {
        selectedStrokeSideAthletes.filter { athlete in
            athlete.name.lowercased().contains(wavesData[waveIndex][crewIndex].searchStrokeText.lowercased())
        }
    }
}

//#Preview {
//    PairsMatrixRunInputView(wavesData: <#Binding<[[PairsCrewInput]]>#>)
//}
