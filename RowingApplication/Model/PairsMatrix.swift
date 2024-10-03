//
//  PairsMatrix.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 02/10/2024.
//

import Foundation

struct PairsMatrix {
    var title: String
    var date = Date()
    var data: [[(AthletePair, AthletePair, Int)]]
}
struct AthletePair {
    var name: String
    var points: Int
}
struct PairsCrewInput {
    var bowName: String = ""
    var strokeName: String = ""
    var startTime: String = ""
    var finishTime: String = ""
}
