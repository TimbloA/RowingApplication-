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
        [Athlete(name: "Ed Slack", side: athleteSide.Bow, weight: 73, height: 187),
         Athlete(name: "Richard Oliverson", side: athleteSide.Stroke, weight: 90, height: 190),
         Athlete(name: "Adi Timblo", side: athleteSide.Cox, weight: 51, height: 172)]
    }
    
    #endif
}
