//
//  SelectionDataViewModel.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 03/10/2024.
//

import Foundation

@Observable
class SelectionDataViewModel: ObservableObject{
    static let shared = SelectionDataViewModel()
    var dataTitle: String = ""
    var athletes:[String] = []
    var strokeSideAthletes: [String] = []
    var bowSideAthletes: [String] = []
    var dataDate = Date()
    var bowRanking: [String] = []
    var strokeRanking: [String] = []
    var crewsData:[[CrewData]] = []
    var currPairsData:[PairsMatrix] = []
    
    private init() {
        currPairsData = currentData.pairsMatrixExamples
    }
    
    func addPairsMatrix() {
        DataManager.shared.pairsData.append(PairsMatrix(title: dataTitle, data: crewsData,athletes: athletes))
        DataManager.shared.saveData()
    }
    
    
    func calculateRankings(_ wavesData: [[PairsCrewInput]]) {
        crewsData = []  // Ensure this is initialized
        athletes = []   // Initialize athletes array
        // Dictionary to track athletes by name
        var athletesDict: [String: AthletePair] = [:]
        
        for waveIndex in 0..<wavesData.count {
            var runData: [CrewData] = []  // Use CrewData instead of tuples
            
            for crewInput in wavesData[waveIndex] {
                // Convert input times
                guard let startTime = Int(crewInput.startTime), let finishTime = Int(crewInput.finishTime) else {
                    continue
                }
                
                let crewTime = finishTime - startTime
                
                // Reuse existing stroke seat or create a new one
                let stroke: AthletePair
                if let existingStroke = athletesDict[crewInput.strokeName] {
                    stroke = existingStroke
                } else {
                    let newStroke = AthletePair(name: crewInput.strokeName, points: 0)
                    athletesDict[crewInput.strokeName] = newStroke
                    stroke = newStroke
                    // Append the stroke's name to the athletes array if not already present
                    if !athletes.contains(crewInput.strokeName) {
                        athletes.append(crewInput.strokeName)
                    }
                }
                
                // Reuse existing bow seat or create a new one
                let bow: AthletePair
                if let existingBow = athletesDict[crewInput.bowName] {
                    bow = existingBow
                } else {
                    let newBow = AthletePair(name: crewInput.bowName, points: 0)
                    athletesDict[crewInput.bowName] = newBow
                    bow = newBow
                    // Append the bow's name to the athletes array if not already present
                    if !athletes.contains(crewInput.bowName) {
                        athletes.append(crewInput.bowName)
                    }
                }
                
                // Create a new CrewData instance for this crew
                let crewData = CrewData(bow: bow, stroke: stroke, time: crewTime)
                runData.append(crewData)
            }
            
            // Sort crews by their times
            let rankedData = runData.sorted(by: { $0.time < $1.time })
            
            // Assign points based on ranking
            for i in 0..<rankedData.count {
                var bow = rankedData[i].bow
                var stroke = rankedData[i].stroke
                
                // Increment points based on their rank
                bow.points += i + 1
                stroke.points += i + 1
                
                // Update athletesDict to reflect the new points
                athletesDict[bow.name] = bow
                athletesDict[stroke.name] = stroke
            }
            
            crewsData.append(rankedData)  // Append ranked data to crewsData
        }
    }


    func rankBowAndStrokeAthletes(crewsData: [[CrewData]]) -> ([AthletePair], [AthletePair]) {
        var bowAthleteDict: [String: AthletePair] = [:] // To store unique bow athletes by name
        var strokeAthleteDict: [String: AthletePair] = [:] // To store unique stroke athletes by name

        // Collect unique bow and stroke athletes from crewsData
        for wave in crewsData {
            for crew in wave {
                let bow = crew.bow
                let stroke = crew.stroke
                
                // Check if the bow athlete already exists, if so, add points
                if let existingBow = bowAthleteDict[bow.name] {
                    bowAthleteDict[bow.name] = AthletePair(name: existingBow.name, points: existingBow.points + bow.points) // Add points to existing athlete
                } else {
                    bowAthleteDict[bow.name] = bow // Add new athlete
                }

                // Check if the stroke athlete already exists, if so, add points
                if let existingStroke = strokeAthleteDict[stroke.name] {
                    strokeAthleteDict[stroke.name] = AthletePair(name: existingStroke.name, points: existingStroke.points + stroke.points) // Add points to existing athlete
                } else {
                    strokeAthleteDict[stroke.name] = stroke // Add new athlete
                }
            }
        }
        
        // Convert dictionary values to array
        let bowAthletes = Array(bowAthleteDict.values)
        let strokeAthletes = Array(strokeAthleteDict.values)
        
        // Sort bow athletes by points (from least to most points)
        let rankedBowAthletes = bowAthletes.sorted(by: { $0.points < $1.points })
        
        // Sort stroke athletes by points (from least to most points)
        let rankedStrokeAthletes = strokeAthletes.sorted(by: { $0.points < $1.points })
        
        return (rankedBowAthletes, rankedStrokeAthletes)
    }


}
