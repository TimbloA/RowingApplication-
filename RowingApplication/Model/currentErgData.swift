//
//  File.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 16/09/2024.
//

import Foundation

struct currentErgData {
    
    #if DEBUG
    static var examples: [ErgData] {
        [ErgData(title: "2k", athlete:currentAthletes.examples[1], distance: 2000)
        ]
    }
    
    #endif
}
