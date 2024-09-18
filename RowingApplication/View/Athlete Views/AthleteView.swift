//
//  AthleteView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 11/09/2024.
//

import SwiftUI

struct AthleteView: View {
    @State var athlete: Athlete
    @StateObject var dataViewModel: DataViewModel = DataViewModel.shared
    var body: some View {
        
        VStack {
            NavigationStack{
                Form{
                    Text("\(athlete.displayAthlete())")
                    NavigationLink(destination:DataListView(Single: true,SingleAthlete: athlete.name)){
                        Text("Athlete Data")
                    }
                }
                
            }
        }
        .padding()
        .onAppear {
            athlete.updateErgs(with: dataViewModel.currErgData)
        }
    }
}

#Preview {
    AthleteView(athlete: Athlete(name: "Ed Slack", side: athleteSide.Stroke, weight: 73, height: 187))
}
