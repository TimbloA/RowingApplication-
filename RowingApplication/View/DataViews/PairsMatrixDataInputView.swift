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
    @State private var wavesData: [[PairsCrewInput]] = []
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

                // Button to generate input fields
                Button(action: {
                    generateInputFields()
                }) {
                    Text("Enter Data")
                        .padding()
                        .foregroundColor(.blue)
                }

                NavigationLink("Data Entry", destination: PairsMatrixRunInputView(wavesData: $wavesData))

                // Display the crew rankings
                ScrollView {
                    ForEach(0..<selectionDataViewModel.crewsData.count, id: \.self) { waveIndex in
                        Section(header: Text("Wave \(waveIndex + 1) Rankings")) {
                            ForEach(0..<selectionDataViewModel.crewsData[waveIndex].count, id: \.self) { crewIndex in
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

                // Button to calculate results
                Button(action: {
                    selectionDataViewModel.calculateRankings(wavesData)
                }) {
                    Text("Calculate Rankings")
                        .padding()
                        .foregroundColor(.blue)
                }
                .padding(.top)

                if !selectionDataViewModel.crewsData.isEmpty {
                    Button(action: {
                        selectionDataViewModel.addPairsMatrix()
                    }) {
                        Text("Submit Entry")
                    }
                }
            }
            .padding()
        }
    }

    // Function to generate input fields dynamically based on noOfWaves and noOfCrews
    func generateInputFields() {
        guard let waves = Int(noOfWaves), let crews = Int(noOfCrews) else {
            return
        }
        // Reset wavesData to accommodate new inputs
        wavesData = Array(repeating: Array(repeating: PairsCrewInput(), count: crews), count: waves)
    }
}


#Preview {
    PairsMatrixDataInputView()
}
