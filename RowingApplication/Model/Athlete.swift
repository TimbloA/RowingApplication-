//
//  Athlete.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 11/09/2024.
//

import Foundation


enum athleteSide: String, CaseIterable, Identifiable {
    case Bow
    case Stroke
    case Both
    case Cox
    var id: Self { self }
}

struct Athlete {
    let name: String
    var side: athleteSide
    var DOB = Date()
    var weight: Int
    var height: Int
    var ergs: [SingleErgData] = []
    
    func formatDate() -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.locale = Locale(identifier: "en_GB")
            let display = formatter.string(from: DOB)
            
            return display
        }
    
    mutating func updateErgs(with currentErgData: [SingleErgData]) {
        ergs = []
          for item in currentErgData {
              if item.athlete == name  {
                  ergs.append(item)
              }
          }
      }
    func displayAthlete()-> String {
            return"""
                  Name: \(name)
                  Side: \(side)
                  Weight: \(weight) kg
                  Height: \(height) cm
                  DOB: \(formatDate())
                  """
        }
}



