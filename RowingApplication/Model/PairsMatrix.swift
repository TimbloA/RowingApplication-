//
//  PairsMatrix.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 02/10/2024.
//

import Foundation

struct CrewData: Codable {
    let bow: AthletePair
    let stroke: AthletePair
    let time: Int

    init(bow: AthletePair, stroke: AthletePair, time: Int) {
        self.bow = bow
        self.stroke = stroke
        self.time = time
    }
}

struct PairsMatrix: Codable, Identifiable {
    let id: UUID
    let title: String
    let data: [[CrewData]]  // Use CrewData instead of tuples
    let athletes: [String]

    init(title: String, data: [[CrewData]], athletes: [String]) {
        self.id = UUID()  // Generate a new UUID for the matrix
        self.title = title
        self.data = data
        self.athletes = athletes
    }
}
struct AthletePair:Codable {
    var name: String
    var points: Int
}
struct PairsCrewInput {
    var bowName: String = ""
    var strokeName: String = ""
    var startTime: String = ""
    var finishTime: String = ""
}
