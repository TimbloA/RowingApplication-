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
    RankedAthletesPairsMatrixView(PairsData: currentData.pairsMatrixExamples[0])
}
