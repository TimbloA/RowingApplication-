//
//  Athlete.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 11/09/2024.
//

import Foundation


enum athleteSide: String, CaseIterable, Identifiable {
    case BowSide
    case StrokeSide
    case Both
    var id: Self { self }
}

struct Athlete {
    let name: String
    var side: athleteSide
    var DOB = Date()
    var weight: Double
    var height: Double
    
    func formatDate() -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.locale = Locale(identifier: "en_GB")
            let display = formatter.string(from: DOB)
            
            return display
        }
    func displayAthlete()-> String {
            return"""
                  Name: \(name)
                  Side: \(side)
                  Weight: \(weight)
                  Height: \(height)
                  Expiry Date: \(formatDate())
                  """
        }
}
