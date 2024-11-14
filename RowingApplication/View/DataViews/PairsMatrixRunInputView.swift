//
//  PairsMatrixRunInputView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 10/10/2024.
//

import SwiftUI

struct PairsMatrixRunInputView: View {
    @Binding var wavesData: [[PairsCrewInput]]
    var selectedBowSideAthletes: [Athlete]
    var selectedStrokeSideAthletes: [Athlete]

    var body: some View {
        ScrollView {
            ForEach(0..<wavesData.count, id: \.self) { waveIndex in
                VStack(alignment: .leading) {
                    Text("Wave \(waveIndex + 1)").font(.headline).padding(.top)
                    ForEach(0..<wavesData[waveIndex].count, id: \.self) { crewIndex in
                        PairsMatrixCrewInputView(
                            crew: $wavesData[waveIndex][crewIndex],
                            selectedBowSideAthletes: selectedBowSideAthletes,
                            selectedStrokeSideAthletes: selectedStrokeSideAthletes
                        )
                    }
                }
            }
        }
        .padding()
        .onTapGesture {
            for waveIndex in wavesData.indices {
                for crewIndex in wavesData[waveIndex].indices {
                    wavesData[waveIndex][crewIndex].searchBowText = ""
                    wavesData[waveIndex][crewIndex].searchStrokeText = ""
                }
            }
        }
    }
}


//#Preview {
//    PairsMatrixRunInputView(wavesData: <#Binding<[[PairsCrewInput]]>#>)
//}
