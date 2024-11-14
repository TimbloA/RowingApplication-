//
//  PairsMatrixCrewInputView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 13/11/2024.
//

import SwiftUI

struct PairsMatrixCrewInputView: View {
    @Binding var crew: PairsCrewInput
    @FocusState private var bowFieldFocused: Bool
    @FocusState private var strokeFieldFocused: Bool
    var selectedBowSideAthletes: [Athlete]
    var selectedStrokeSideAthletes: [Athlete]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Crew").font(.headline)
            
            TextField("Bow Name", text: $crew.bowName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($bowFieldFocused)
                .onChange(of: crew.bowName) { newValue in
                    crew.searchBowText = newValue
                }
                .onSubmit {
                    bowFieldFocused = false
                    crew.searchBowText = ""
                }
            
            AthleteAutocompleteView(
                searchText: $crew.searchBowText,
                filteredAthletes: filteredBowAthletes()
            ) { selectedAthlete in
                crew.bowName = selectedAthlete.name
                crew.searchBowText = ""
                bowFieldFocused = false
            }
            
            TextField("Stroke Name", text: $crew.strokeName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($strokeFieldFocused)
                .onChange(of: crew.strokeName) { newValue in
                    crew.searchStrokeText = newValue
                }
                .onSubmit {
                    strokeFieldFocused = false
                    crew.searchStrokeText = ""
                }
            
            AthleteAutocompleteView(
                searchText: $crew.searchStrokeText,
                filteredAthletes: filteredStrokeAthletes()
            ) { selectedAthlete in
                crew.strokeName = selectedAthlete.name
                crew.searchStrokeText = ""
                strokeFieldFocused = false
            }
            
            Text("Start Time")
            TimeInputView(timeTenths: $crew.startTime)
            Text("Finish Time")
            TimeInputView(timeTenths: $crew.finishTime)
        }
        .padding(.bottom)
    }
    
    private func filteredBowAthletes() -> [Athlete] {
        selectedBowSideAthletes.filter { athlete in
            athlete.name.lowercased().contains(crew.searchBowText.lowercased())
        }
    }
    
    private func filteredStrokeAthletes() -> [Athlete] {
        selectedStrokeSideAthletes.filter { athlete in
            athlete.name.lowercased().contains(crew.searchStrokeText.lowercased())
        }
    }
}

