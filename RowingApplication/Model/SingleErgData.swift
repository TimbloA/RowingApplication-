//
//  ErgData.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 16/09/2024.
//

import Foundation

struct SingleErgData: Codable, Identifiable {
    var id = UUID() // Unique identifier
    var title: String
    var athlete: String
    var date = Date()
    var distance: Int
    var time:Int = 0
    var ergDataPoints:[ErgIntervalData] = []
    var averageRate: Double = 0
   func displayData()-> String {
        return"""
              Title: \(title)
              Athlete: \(athlete)
              Distance: \(distance)m
              Time: \(time.convertTenthsOfSeconds(time))
              Date: \(date.formatDate(date:date))
              Average Rate: \(averageRate)spm
              """
    }
}


struct ErgIntervalData: Codable {
    var distance: String
    var split: String
    var rate: String
}
