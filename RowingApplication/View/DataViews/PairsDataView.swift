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
                        let crew = pairsData.data[waveIndex][crewIndex] // crew is of type CrewData now
                        HStack {
                            Text("B: \(crew.bow.name) \n Points: \(crew.bow.points)")
                            Spacer()
                            Text("S: \(crew.stroke.name) \n Points: \(crew.stroke.points)")
                            Spacer()
                            Text("Time: \(crew.time.convertTenthsOfSeconds(crew.time))")
                        }
                    }
                }
            }
        }
    }

}

#Preview {
    PairsDataView(pairsData:PairsMatrix(title: "VIII Pairs", data: [
        [
            CrewData(bow: AthletePair(name: "Henry Clarke", points: 1), stroke: AthletePair(name: "Ed Slack", points: 1), time: 40),
            CrewData(bow: AthletePair(name: "Nikolai Rybin", points: 2), stroke: AthletePair(name: "Richard Oliverson", points: 2), time: 40),
            CrewData(bow: AthletePair(name: "George Konig", points: 3), stroke: AthletePair(name: "Charlie Bowker", points: 3), time: 41)
        ],
        [
            CrewData(bow: AthletePair(name: "Nikolai Rybin", points: 1), stroke: AthletePair(name: "Ed Slack", points: 1), time: 42),
            CrewData(bow: AthletePair(name: "George Konig", points: 2), stroke: AthletePair(name: "Richard Oliverson", points: 2), time: 42),
            CrewData(bow: AthletePair(name: "Henry Clarke", points: 3), stroke: AthletePair(name: "Charlie Bowker", points: 3), time: 42)
        ]
    ], athletes: [
        "Ed Slack",
        "Richard Oliverson",
        "Charlie Bowker",
        "Henry Clarke",
        "Nikolai Rybin",
        "George Konig"
    ],date:Date()))
}
