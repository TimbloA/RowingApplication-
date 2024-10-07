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
        [PairsMatrix(title:"VIII Pairs",data:[
            // Wave 1
            [
                (AthletePair(name: "Athlete A", points: 1), AthletePair(name: "Athlete Z", points: 1), 40), // 50 - 10
                (AthletePair(name: "Athlete B", points: 2), AthletePair(name: "Athlete Y", points: 2), 40), // 51 - 11
                (AthletePair(name: "Athlete C", points: 3), AthletePair(name: "Athlete X", points: 3), 41)  // 53 - 12
            ],
            // Wave 2
            [
                (AthletePair(name: "Athlete B", points: 1), AthletePair(name: "Athlete Z", points: 1), 42), // 52 - 10
                (AthletePair(name: "Athlete C", points: 2), AthletePair(name: "Athlete Y", points: 2), 42), // 55 - 13
                (AthletePair(name: "Athlete A", points: 3), AthletePair(name: "Athlete X", points: 3), 42)  // 56 - 14
            ]
        ])]

    }

    #endif
}
