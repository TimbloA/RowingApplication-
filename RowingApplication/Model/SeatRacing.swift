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

func performSeatRace(crew1: inout SeatRaceCrew, crew2: inout SeatRaceCrew, maxSwaps: Int) {
    let originalDifference = abs(crew1.raceTime - crew2.raceTime)
    print("Original time difference: \(originalDifference)")

    for swapCount in 1...maxSwaps {
        print("\n** Swap \(swapCount) **")
        
        let athlete1Index = swapCount % crew1.athletes.count
        let athlete2Index = swapCount % crew2.athletes.count
        
        swapAthletes(crew1: &crew1, crew2: &crew2, athlete1Index: athlete1Index, athlete2Index: athlete2Index)
        print("Swapped Athlete \(crew1.athletes[athlete1Index].name) with \(crew2.athletes[athlete2Index].name)")

        
        crew1.raceTime += Double.random(in: -2.0...2.0)
        crew2.raceTime += Double.random(in: -2.0...2.0)

        // Check the new difference
        let newDifference = abs(crew1.raceTime - crew2.raceTime)
        print("New time difference: \(newDifference)")

        if newDifference < originalDifference {
            print("Swap \(swapCount) improved performance!")
        } else {
            print("Swap \(swapCount) did not improve performance.")
        }
    }
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
