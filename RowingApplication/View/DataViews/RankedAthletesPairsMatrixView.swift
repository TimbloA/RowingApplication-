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
        VStack {
                    // Button to calculate rankings
                    Button(action: {
                        let (bowAthletes, strokeAthletes) = selectionDataViewModel.rankBowAndStrokeAthletes(crewsData: PairsData.data)
                        rankedBowAthletes = bowAthletes
                        rankedStrokeAthletes = strokeAthletes
                    }) {
                        Text("Calculate Rankings")
                            .padding()
                            .foregroundColor(.blue)
                            .cornerRadius(8)
                    }
                    .padding(.bottom, 20)
                    
                    // Output Ranked Bow Athletes Section
                    VStack(alignment: .leading) {
                        Text("Ranked Bow Athletes")
                            .font(.headline)
                            .padding(.bottom, 10)
                        
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
                    .padding(.bottom, 20)
                    
                    // Output Ranked Stroke Athletes Section
                    VStack(alignment: .leading) {
                        Text("Ranked Stroke Athletes")
                            .font(.headline)
                            .padding(.bottom, 10)
                        
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
                }
                .padding()
            }
}

#Preview {
    RankedAthletesPairsMatrixView(PairsData: currentData.pairsMatrixExamples[0])
}
