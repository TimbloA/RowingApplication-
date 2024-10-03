//
//  PairsDataView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 03/10/2024.
//

import SwiftUI

struct PairsDataView: View {
    @StateObject var selectionDataViewModel: SelectionDataViewModel = SelectionDataViewModel.shared
    var body: some View {
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
}

#Preview {
    PairsDataView()
}
