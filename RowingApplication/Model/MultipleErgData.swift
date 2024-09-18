//
//  MultipleErgData.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 18/09/2024.
//

import Foundation

struct MultipleErgData {
    var title: String
    var athletes: [String]
    var date = Date()
    var distance: Int
    var allErgs: [SingleErgData] = []


   
    func formatDate() -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.locale = Locale(identifier: "en_GB")
            let display = formatter.string(from: date)
            
            return display
        }
    mutating func updateErgs(with currentErgData: [SingleErgData]) {
          for item in currentErgData {
              if item.date == date && item.title == title && athletes.contains(item.athlete) {
                  allErgs.append(item)
              }
          }
      }
    func displayData()-> String {
            return"""
                  Name: \(title)
                  Athletes: \(athletes)
                  Distance: \(distance)m
                  Date: \(formatDate())
                  """
        }

}
