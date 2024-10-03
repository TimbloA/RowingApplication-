//
//  PairsMatrixDataView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 02/10/2024.
//

import SwiftUI






// Main SwiftUI View
struct PairsMatrixDataInputView: View {
    @StateObject var selectionDataViewModel: SelectionDataViewModel = SelectionDataViewModel.shared
    @State private var noOfWaves: String = ""
    @State private var noOfCrews: String = ""
    @State private var wavesData: [[PairsCrewInput]] = []
    @State private var crewsData: [[(AthletePair, AthletePair, Int)]] = [] 
    var body: some View {
        VStack {
            // Text fields to input number of waves and crews
            TextField("Title",text: $selectionDataViewModel.dataTitle)
            TextField("Enter number of waves", text: $noOfWaves)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.numberPad)
            
            TextField("Enter number of crews per wave", text: $noOfCrews)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.numberPad)
            
            // Button to generate input fields
            Button(action: {
                generateInputFields()
            }) {
                Text("Enter Data")
                    .padding()
                    .foregroundColor(.blue)
                    .cornerRadius(8)
            }
            ScrollView {
                ForEach(0..<wavesData.count, id: \.self) { waveIndex in
                    VStack(alignment: .leading) {
                        Text("Wave \(waveIndex + 1)").font(.headline).padding(.top)
                        ForEach(0..<wavesData[waveIndex].count, id: \.self) { crewIndex in
                            VStack(alignment: .leading) {
                                Text("Crew \(crewIndex + 1)")
                                
                                TextField("Bow Name", text: $wavesData[waveIndex][crewIndex].bowName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                
                                TextField("Stroke Name", text: $wavesData[waveIndex][crewIndex].strokeName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                
                                TextField("Start Time", text: $wavesData[waveIndex][crewIndex].startTime)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.numberPad)
                                
                                TextField("Finish Time", text: $wavesData[waveIndex][crewIndex].finishTime)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.numberPad)
                            }
                            .padding(.bottom)
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
                    .foregroundColor(.green)
                    .cornerRadius(8)
            }
            .padding(.top)
            
            // Display the crew rankings
            List {
                ForEach(0..<selectionDataViewModel.crewsData.count, id: \.self) { waveIndex in
                    Section(header: Text("Wave \(waveIndex + 1) Rankings")) {
                        ForEach(0..<selectionDataViewModel.crewsData[waveIndex].count, id: \.self) { crewIndex in
                            let crew = selectionDataViewModel.crewsData[waveIndex][crewIndex]
                            HStack {
                                Text("Bow: \(crew.0.name) (Points: \(crew.0.points))")
                                Spacer()
                                Text("Stroke: \(crew.1.name) (Points: \(crew.1.points))")
                                Spacer()
                                Text("Time: \(crew.2)")
                            }
                        }
                    }
                }
            }
           
        }
        .padding()
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
