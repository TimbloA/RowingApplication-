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
    var athleteWeight: Int = 70
    var athleteHeight: Int = 180
    var athleteCrew = ""
    var newAthlete: Bool = false
    let range1 = 20...200
    let step1:Int = 1
    let range2 = 100...250
    let step2:Int = 1


    var athleteSide: athleteSide = .Both

    var athleteDOB = Date()

    var submitName: String = "Submit Athlete"
    
    private init() {
        currAthletes = currentAthletes.examples
    }
    
    func addNewAthlete() {
        DataManager.shared.athletes.append(Athlete(name: athleteName, side: athleteSide, DOB: athleteDOB, weight: athleteWeight, height: athleteHeight))
       submitName = "Submitted!"
       
        resetDisplay()
        DataManager.shared.saveData()
        
    }
    func resetDisplay() {
        athleteName = ""
        athleteWeight = 70
        athleteHeight = 180
        athleteSide = .Both
        athleteDOB = Date()
        submitName = "Submit Athlete"
        newAthlete = false
    }
    
}
