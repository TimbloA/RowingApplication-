//
//  Date.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 19/09/2024.
//

import Foundation

extension Date {
    func formatDate(date:Date) -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
//        Formats the date to the GB style of Day, Month Year
            formatter.locale = Locale(identifier: "en_GB")
            let display = formatter.string(from: date)
            
            return display
        }

}
