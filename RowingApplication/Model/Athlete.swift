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

struct Athlete: Identifiable, Codable, Hashable {
    var id = UUID() // Unique identifier
    let name: String
    var side: athleteSide
    var DOB: Date
    var weight: Int
    var height: Int

    func displayAthlete()-> String {
            return"""
                  Name: \(name)
                  Side: \(side)
                  Weight: \(weight) kg
                  Height: \(height) cm
                  DOB: \(DOB.formatDate(date:DOB))
                  """
        }
}



