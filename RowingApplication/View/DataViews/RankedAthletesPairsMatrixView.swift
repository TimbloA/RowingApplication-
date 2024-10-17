//
//  RankedAthletesPairsMatrixView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 07/10/2024.
//

import SwiftUI

struct RankedAthletesPairsMatrixView: View {
    @StateObject var selectionDataViewModel: SelectionDataViewModel = SelectionDataViewModel.shared
    @State var PairsData:PairsMatrix
    
    @State var rankedBowAthletes:[AthletePair] = []
    @State var rankedStrokeAthletes:[AthletePair] = []
    var body: some View {
        NavigationStack{
            VStack {
                // Output Ranked Bow Athletes Section
                VStack(alignment: .leading) {
                    Text("Ranked Bow Side Athletes")
                        .font(.headline)
                    
                    List(rankedBowAthletes, id: \.name) { athlete in
                        HStack {
                            Text(athlete.name)
                                .font(.body)
                            Spacer()
                            Text("\(athlete.points) points")
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()
                
                // Output Ranked Stroke Athletes Section
                VStack(alignment: .leading) {
                    Text("Ranked Stroke Side Athletes")
                        .font(.headline)
                    
                    List(rankedStrokeAthletes, id: \.name) { athlete in
                        HStack {
                            Text(athlete.name)
                                .font(.body)
                            Spacer()
                            Text("\(athlete.points) points")
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()
                Spacer()
            }
            NavigationLink("See Data", destination: PairsDataView(pairsData:PairsData) )
            .padding()
            .onAppear(perform: {
                // to calculate rankings
                
                let (bowAthletes, strokeAthletes) = selectionDataViewModel.rankBowAndStrokeAthletes(crewsData: PairsData.data)
                rankedBowAthletes = bowAthletes
                rankedStrokeAthletes = strokeAthletes
            })
            
        }
    }
}

#Preview {
    RankedAthletesPairsMatrixView(PairsData: PairsMatrix(title: "VIII Pairs", data: [
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
    ]))
}
