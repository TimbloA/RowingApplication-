//
//  File.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 16/09/2024.
//

import Foundation

struct currentErgData {
    
    #if DEBUG
    static var singleExamples: [SingleErgData] {
        [SingleErgData(title: "2K", athlete:"Ed Slack", distance: 2000),
         SingleErgData(title: "5K", athlete:"Ed Slack", distance: 5000)
         
        ]
    }
    static var multipleExamples: [MultipleErgData] {
        [MultipleErgData(title: "2K", athletes:["Ed Slack","Richard Oliverson"], distance: 2000),
         MultipleErgData(title: "5K", athletes:["Ed Slack","Adi Timblo"], distance: 5000)
         
        ]
    }

    #endif
}
