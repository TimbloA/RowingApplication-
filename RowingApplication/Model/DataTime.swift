//
//  DataTime.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 18/09/2024.
//

import Foundation

struct DataTime {
    var minutes: Int = 0
    var seconds: Int = 0
    var tenths: Int = 0

    var totalSeconds: Double {
        return Double(minutes * 60 + seconds) + Double(tenths) / 10.0
    }

    init(minutes: Int = 0, seconds: Int = 0, tenths: Int = 0) {
        self.minutes = minutes
        self.seconds = seconds
        self.tenths = tenths
    }
}
