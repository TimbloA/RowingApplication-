//
//  PairsMatrixDataView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 02/10/2024.
//

import SwiftUI

struct PairsMatrixDataInputView: View {
    @StateObject var selectionDataViewModel: SelectionDataViewModel = SelectionDataViewModel.shared
    @State private var noOfWaves: String = ""
    @State private var noOfCrews: String = ""
    @State private var wavesData: [[PairsCrewInput]] = [] // Stores user-input crew data
    
    @State private var rankingsCalculated = false // Tracks if rankings are calculated
    @State private var showBowSideSelection = false // Tracks the state of showing the bow side athletes selection
    @State private var showStrokeSideSelection = false // Tracks the state of showing the stroke side athletes selection
    
    @State private var selectedBowSideAthletes: [Athlete] = [] // Store selected bow side athletes
    @State private var selectedStrokeSideAthletes: [Athlete] = [] // Store selected stroke side athletes
    
    var body: some View {
        NavigationStack {
            VStack {
                // Text fields to input number of waves and crews
                Text("Pairs Data")
                    .font(.title)
                    .bold()
                
                HStack {
                    Text("    Title:")
                    TextField("Title", text: $selectionDataViewModel.dataTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                HStack {
                    DatePicker("     Date:", selection: $selectionDataViewModel.dataDate, displayedComponents: [.date])
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                HStack {
                    Text("Waves:")
                    TextField("Enter number of waves", text: $noOfWaves)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                }

                HStack {
                    Text("Crews:")
                    TextField("Enter number of crews per wave", text: $noOfCrews)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                }

                // Button to select Bow Side Athletes
                Button(action: {
                    showBowSideSelection.toggle() // Toggle the bow side athlete selection list
                }) {
                    Text("Select Bow Side Athletes")
                        .padding()
                        .foregroundColor(.blue)
                }
                .sheet(isPresented: $showBowSideSelection) {
                    AthleteSelectionView(selectedAthletes: $selectedBowSideAthletes)
                }

                // Button to select Stroke Side Athletes
                Button(action: {
                    showStrokeSideSelection.toggle() // Toggle the stroke side athlete selection list
                }) {
                    Text("Select Stroke Side Athletes")
                        .padding()
                        .foregroundColor(.blue)
                }
                .sheet(isPresented: $showStrokeSideSelection) {
                    AthleteSelectionView(selectedAthletes: $selectedStrokeSideAthletes)
                }

                // Button to generate input fields
                Button(action: {
                    generateInputFields()
                    rankingsCalculated = false // Reset rankings calculation state
                }) {
                    Text("Enter Data")
                        .padding()
                        .foregroundColor(.blue)
                }

                // Only show this link if wavesData is not empty
                if !wavesData.isEmpty {
                    NavigationLink("Data Entry", destination: PairsMatrixRunInputView(wavesData: $wavesData,
                        selectedBowSideAthletes: selectedBowSideAthletes,
                        selectedStrokeSideAthletes: selectedStrokeSideAthletes))

                }

                // Display the crew rankings
                if !selectionDataViewModel.crewsData.isEmpty {
                    ScrollView {
                        ForEach(selectionDataViewModel.crewsData.indices, id: \.self) { waveIndex in
                            Section(header: Text("Wave \(waveIndex + 1) Rankings")) {
                                ForEach(selectionDataViewModel.crewsData[waveIndex].indices, id: \.self) { crewIndex in
                                    let crew = selectionDataViewModel.crewsData[waveIndex][crewIndex] // Accessing CrewData

                                    HStack {
                                        Text("B: \(crew.bow.name) \n Points: \(crew.bow.points)")  // Using CrewData's bow
                                        Spacer()
                                        Text("S: \(crew.stroke.name) \n Points: \(crew.stroke.points)")  // Using CrewData's stroke
                                        Spacer()
                                        Text("Time: \(crew.time.convertTenthsOfSeconds(crew.time))")  // Using CrewData's time
                                    }
                                }
                            }
                        }
                    }
                }


                // Button to calculate results (enabled if wavesData is not empty)
                Button(action: {
                    selectionDataViewModel.calculateRankings(wavesData)
                    rankingsCalculated = true // Indicate that rankings have been calculated
                }) {
                    Text("Calculate Rankings")
                    .padding()
                    .foregroundColor(.blue)
                }
                .disabled(wavesData.isEmpty) // Disable until wavesData is set
                .padding(.top)

            

                // Show "Submit Entry" button only after rankings have been calculated
                if rankingsCalculated && !selectionDataViewModel.crewsData.isEmpty {
                    Button(action: {
                        selectionDataViewModel.addPairsMatrix()
                        resetForm() // Clear the form after submission
                    }) {
                        Text("Submit Entry")
                            .padding()
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding()
        }
    }

    // Function to generate input fields dynamically based on noOfWaves and noOfCrews
    func generateInputFields() {
        guard let waves = Int(noOfWaves), let crews = Int(noOfCrews), waves > 0, crews > 0 else {
            return // Ensure valid number of waves and crews
        }
        // Reset wavesData to accommodate new inputs
        wavesData = Array(repeating: Array(repeating: PairsCrewInput(), count: crews), count: waves)
        selectionDataViewModel.crewsData.removeAll() // Clear previous rankings
    }

    // Function to reset the form after submission
    func resetForm() {
        noOfWaves = ""
        noOfCrews = ""
        wavesData.removeAll()
        rankingsCalculated = false
        selectedBowSideAthletes.removeAll()
        selectedStrokeSideAthletes.removeAll()
    }
}

#Preview {
    PairsMatrixDataInputView()
}
