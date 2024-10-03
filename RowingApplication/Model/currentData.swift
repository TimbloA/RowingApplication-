//
//  File.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 16/09/2024.
//

import Foundation

struct currentData {
    
    #if DEBUG
    static var ergExamples: [SingleErgData] {
        [SingleErgData(title: "2K", athlete:"Ed Slack", distance: 2000),
         SingleErgData(title: "5K", athlete:"Ed Slack", distance: 5000),
         SingleErgData(title: "4K", athlete:"Adi Timblo", distance: 5000)
        ]
        
    }
    static var trainingExamples: [TrainingData] {
        [TrainingData(title: "12K UT2", crew: "2nd VIII", distance: 12000,time: 12033,notes:"Slight easterly breeze.")]
    }
    static var pairsMatrixExamples: [PairsMatrix] {
            [[
            // Wave 1
            [
                (AthletePair(name: "Bow A1", points: 1), AthletePair(name: "Stroke A1", points: 1), 40), // Crew time: 50 - 10
                (AthletePair(name: "Bow A2", points: 2), AthletePair(name: "Stroke A2", points: 2), 43), // Crew time: 55 - 12
                (AthletePair(name: "Bow A3", points: 3), AthletePair(name: "Stroke A3", points: 3), 45)  // Crew time: 60 - 15
            ],
            // Wave 2
            [
                (AthletePair(name: "Bow B1", points: 1), AthletePair(name: "Stroke B1", points: 1), 40), // Crew time: 49 - 9
                (AthletePair(name: "Bow B2", points: 2), AthletePair(name: "Stroke B2", points: 2), 43), // Crew time: 54 - 11
                (AthletePair(name: "Bow B3", points: 3), AthletePair(name: "Stroke B3", points: 3), 47)  // Crew time: 61 - 14
            ]
        ]]

    }

    #endif
}
