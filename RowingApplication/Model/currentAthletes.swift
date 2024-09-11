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
        [Athlete(name: "Ed Slack", side: athleteSide.BowSide, weight: 73.3, height: 187.5)]
    }
    
    #endif
}
