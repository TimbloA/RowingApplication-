//
//  AthleteView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 11/09/2024.
//

import SwiftUI

struct AthleteView: View {
    let athlete: Athlete
    var body: some View {
        VStack {
            
            Form{
                Text("\(athlete.displayAthlete())")
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AthleteView(athlete: Athlete(name: "Ed Slack", side: athleteSide.Stroke, weight: 73, height: 187))
}
