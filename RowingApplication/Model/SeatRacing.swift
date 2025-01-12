//
//  SeatRacing.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 19/11/2024.
//

import Foundation

struct SeatRaceCrew {
    var athletes: [Athlete]
    var raceTime: Double
}


func swapAthletes(crew1: inout SeatRaceCrew, crew2: inout SeatRaceCrew, athlete1Index: Int, athlete2Index: Int) {
    guard athlete1Index < crew1.athletes.count, athlete2Index < crew2.athletes.count else {
        print("Invalid indices for swapping.")
        return
    }
    let temp = crew1.athletes[athlete1Index]
    crew1.athletes[athlete1Index] = crew2.athletes[athlete2Index]
    crew2.athletes[athlete2Index] = temp
}
struct SeatRace: Codable, Identifiable  {
    let id: UUID
    let title: String
    let data: [String] // Use CrewData instead of tuples
    let dataDate:Date

    init(title: String, data: [String],date: Date) {
        self.id = UUID()  // Generate a new UUID for the matrix
        self.title = title
        self.data = data
        self.dataDate = date
    }
}
