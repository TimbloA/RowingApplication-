//
//  ErgData.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 16/09/2024.
//

import Foundation

struct SingleErgData {
    var title: String
    var athlete: String
    var date = Date()
    var distance: Int
    var time:Int = 0

   
    func formatDate() -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.locale = Locale(identifier: "en_GB")
            let display = formatter.string(from: date)
            
            return display
        }
    func convertTenthsOfSeconds(_ tenths: Int) -> String {
        let totalSeconds = tenths / 10
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        let remainingTenths = tenths % 10
        return ("\(minutes):\(seconds).\(remainingTenths)")
    }
    func displayData()-> String {
            return"""
                  Name: \(title)
                  Athlete: \(athlete)
                  Distance: \(distance)m
                  Time: \(convertTenthsOfSeconds(time))
                  Date: \(formatDate())
                  """
        }
}


