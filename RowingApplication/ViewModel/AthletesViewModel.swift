//
//  AthletesViewModel.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 11/09/2024.
//

import Foundation

@Observable
class AthletesViewModel: ObservableObject{
    static let shared = AthletesViewModel()
    var currAthletes: [Athlete]
    var athleteName = ""
    var athleteWeight: Double = 0
    var athleteHeight: Double = 0
    var newAthlete: Bool = false
    let range = 20..<200
    let step:Double = 0.5

//    enum athleteSide: String, CaseIterable, Identifiable {
//        case BowSide, StrokeSide, Both
//        var id: Self { self }
//    }
    var athleteSide: athleteSide = .Both

    var athleteDOB = Date()

    var submitName: String = "Submit Athlete"
    
    private init() {
        currAthletes = currentAthletes.examples
    }
    
    func addNewIngredient() {
       currAthletes.append(Athlete(name: athleteName, side: athleteSide, DOB: athleteDOB, weight: athleteWeight, height: athleteHeight))
       submitName = "Submitted!"
       
        resetDisplay()
        
    }
    func resetDisplay() {
        athleteName = ""
        athleteWeight = 0
        athleteHeight = 0
        athleteSide = .Both
        athleteDOB = Date()
        submitName = "Submit Athlete"
    }
}
