//
//  RowingApplicationApp.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 11/09/2024.
//

import SwiftUI

@main
struct RowingApplicationApp: App {
    var body: some Scene {
        WindowGroup {
            AthleteView(athlete: Athlete(name: "Ed Slack", side: athleteSide.Stroke, weight: 73, height: 187))
        }
    }
}
