//
//  TrainingData.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 19/09/2024.
//

import Foundation

struct TrainingData {
    var title: String
    var date = Date()
    var crew: String
    var distance: Int
    var time: Int = 0
    var notes: String = ""
    
    func displayData()-> String {
         return"""
               Title: \(title)
               Crew: \(crew)
               Distance: \(distance)m
               Time: \(time.convertTenthsOfSeconds(time))
               Date: \(date.formatDate(date:date))
               Notes:
               \(notes)
               """
     }
}
