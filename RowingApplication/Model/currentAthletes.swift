//
//  currentAthletes.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 11/09/2024.
//


import Foundation

struct currentAthletes {
    
    #if DEBUG
    static var examples: [Athlete] {
        // Check if the athlete data is empty; if so, provide example athletes
        return DataManager.shared.athletes.isEmpty ? [
            Athlete(name: "Ed Slack", side: athleteSide.Bow, DOB: Date(), weight: 73, height: 187),
            Athlete(name: "Richard Oliverson", side: athleteSide.Stroke, DOB: Date(), weight: 90, height: 190),
            Athlete(name: "Adi Timblo", side: athleteSide.Cox, DOB: Date(), weight: 51, height: 172)
        ] : DataManager.shared.athletes
    }
    #endif
}
