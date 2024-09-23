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


    #endif
}
