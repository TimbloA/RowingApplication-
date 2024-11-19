//
//  Athlete.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 11/09/2024.
//

import Foundation


enum athleteSide: String, CaseIterable, Identifiable, Codable { // Conform to Codable
    case Bow
    case Stroke
    case Both
    case Cox
    var id: Self { self }
}

class Athlete: Identifiable, Codable, Hashable {
    var id = UUID() // Unique identifier
    let name: String
    var side: athleteSide
    var DOB: Date
    var weight: Int
    var height: Int

    init(name: String, side: athleteSide, DOB: Date, weight: Int, height: Int) {
        self.name = name
        self.side = side
        self.DOB = DOB
        self.weight = weight
        self.height = height
    }
    
    static func == (lhs: Athlete, rhs: Athlete) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    func displayAthlete() -> String {
        return """
               Name: \(name)
               Side: \(side)
               Weight: \(weight) kg
               Height: \(height) cm
               DOB: \(DOB.formatDate(date: DOB))
               """
    }
}



