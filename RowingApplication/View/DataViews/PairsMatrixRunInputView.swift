//
//  PairsMatrixRunInputView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 10/10/2024.
//

import SwiftUI

struct PairsMatrixRunInputView: View {
    @Binding var wavesData: [[PairsCrewInput]]
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
                            
                            TextField("Stroke Name", text: $wavesData[waveIndex][crewIndex].strokeName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
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
            
    }
}

//#Preview {
//    PairsMatrixRunInputView(wavesData: <#Binding<[[PairsCrewInput]]>#>)
//}
