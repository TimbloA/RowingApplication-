//
//  RateCheck.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 17/11/2024.
//

import Foundation


struct RateCheck {
    private var strokeTimestamps: [Date] = []
    var strokesPerMinute: Double = 0.0
    
    mutating func recordStroke() {
        let now = Date()
        strokeTimestamps.append(now)
        
        if strokeTimestamps.count >= 3 {
            strokeTimestamps.removeFirst()
        }
        
        if strokeTimestamps.count >= 2 {
            let intervals = zip(strokeTimestamps.dropLast(), strokeTimestamps.dropFirst())
                .map { $1.timeIntervalSince($0) }
            
            let averageInterval = intervals.reduce(0, +) / Double(intervals.count) 
            strokesPerMinute = 60.0 / averageInterval
        }
    }
}

