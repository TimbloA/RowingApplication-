//
//  AthleteView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 11/09/2024.
//

import SwiftUI

struct AthleteView: View {
    @State var athlete: Athlete
    
    var body: some View {
        
        VStack {
            NavigationStack{ 
                Form{
                    Text("\(athlete.displayAthlete())")
                    
                }
                Form{
                    ForEach(athlete.ergs,id: \.self.title) { erg in
                        NavigationLink(destination: ErgDataView(ErgData: erg)){
                            Text("\(erg.title)")
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            athlete.updateErgs(with: currentErgData.singleExamples)
        }
    }
}

#Preview {
    AthleteView(athlete: Athlete(name: "Ed Slack", side: athleteSide.Stroke, weight: 73, height: 187))
}
