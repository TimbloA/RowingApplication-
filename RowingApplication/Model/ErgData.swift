//
//  ErgData.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 16/09/2024.
//

import Foundation

struct ErgData {
    var title: String
    var athlete: Athlete
    var date = Date()
    var distance: Int
    var timeComponents = DateComponents()

   
    func formatDate() -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.locale = Locale(identifier: "en_GB")
            let display = formatter.string(from: date)
            
            return display
        }
    func displayData()-> String {
            return"""
                  Name: \(title)
                  Athlete: \(athlete.name)
                  Distance: \(distance)m
                  Time: \(String(describing: timeComponents.minute)):\(String(describing: timeComponents.second)):\(String(describing: timeComponents.nanosecond))
                  Date: \(formatDate())
                  """
        }
}


