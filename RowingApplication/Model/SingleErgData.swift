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

   func displayData()-> String {
        return"""
              Title: \(title)
              Athlete: \(athlete)
              Distance: \(distance)m
              Time: \(time.convertTenthsOfSeconds(time))
              Date: \(date.formatDate(date:date))
              """
    }
}


