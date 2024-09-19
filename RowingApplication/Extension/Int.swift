//
//  Int.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 19/09/2024.
//

import Foundation

extension Int {
    func convertTenthsOfSeconds(_ tenths: Int) -> String {
        let totalSeconds = tenths / 10
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        let remainingTenths = tenths % 10
    return ("\(formatToTwoDigits(hours)):\(formatToTwoDigits(minutes)):\(formatToTwoDigits(seconds)).\(remainingTenths)")
    }
    func formatToTwoDigits(_ number: Int) -> String {
        return String(format: "%02d", number)
    }

}
