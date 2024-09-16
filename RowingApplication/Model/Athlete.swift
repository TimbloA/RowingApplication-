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
    var ergs: [String] = []
    
    func formatDate() -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.locale = Locale(identifier: "en_GB")
            let display = formatter.string(from: DOB)
            
            return display
        }
    func updateErgs()-> [ErgData]{
        var tempErgs:String = []
        for item in currentErgData.examples {
            if item.athlete.name == name{
                tempErgs.append(item.title)
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



