//
//  PairsDataView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 03/10/2024.
//

import SwiftUI

struct PairsDataView: View {
    @StateObject var selectionDataViewModel: SelectionDataViewModel = SelectionDataViewModel.shared
    @State var pairsData: PairsMatrix
    var body: some View {
        List {
            ForEach(0..<pairsData.data.count, id: \.self) { waveIndex in
                Section(header: Text("Wave \(waveIndex + 1) Rankings")) {
                    ForEach(0..<pairsData.data[waveIndex].count, id: \.self) { crewIndex in
                        let crew = pairsData.data[waveIndex][crewIndex]
                        HStack {
                            Text("B: \(crew.0.name) \n Points: \(crew.0.points)")
                            Spacer()
                            Text("S: \(crew.1.name) \n Points: \(crew.1.points)")
                            Spacer()
                            Text("Time: \(crew.2.convertTenthsOfSeconds(crew.2))")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PairsDataView(pairsData:currentData.pairsMatrixExamples[0])
}
