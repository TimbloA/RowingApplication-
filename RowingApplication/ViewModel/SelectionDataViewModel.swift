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
    
    
    func addPairsMatrix() {
        DataManager.shared.pairsData.append(PairsMatrix(title: dataTitle, data: crewsData,athletes: athletes,date:dataDate))
        DataManager.shared.saveData()
        dataTitle = ""
    }
    
    
    func calculateRankings(_ wavesData: [[PairsCrewInput]]) {
        // Reset crews data
        crewsData = []
        var athletesDict = [String: AthletePair]() // Initialize a dictionary to track athletes

        for waveIndex in 0..<wavesData.count {
            var runData: [CrewData] = [] // Use CrewData for storing crew information
            
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
                    stroke = AthletePair(name: crewInput.strokeName, points: 0)
                    athletesDict[crewInput.strokeName] = stroke // Add to dictionary
                }
                
                // Reuse existing bow seat or create a new one
                let bow: AthletePair
                if let existingBow = athletesDict[crewInput.bowName] {
                    bow = existingBow
                } else {
                    bow = AthletePair(name: crewInput.bowName, points: 0)
                    athletesDict[crewInput.bowName] = bow // Add to dictionary
                }
                
                // Create a new CrewData instance for this crew
                let crewData = CrewData(bow: bow, stroke: stroke, time: crewTime)
                runData.append(crewData)
            }
            
            // Sort crews by their times (ascending)
            let rankedData = runData.sorted(by: { $0.time < $1.time })
            
            // Assign points based on ranking
            for i in 0..<rankedData.count {
                var bow = rankedData[i].bow
                var stroke = rankedData[i].stroke
                
                // Points earned in this round (1 for first, 2 for second, etc.)
                let pointsEarned = (i + 1)
                
                // Update bow and stroke points for this round
                bow.points = pointsEarned // Assign points earned in this round
                stroke.points = pointsEarned
                
                // Update the athletes dictionary with new points
                athletesDict[bow.name] = bow
                athletesDict[stroke.name] = stroke
                
                // Update crew data with the new points
                let updatedCrewData = CrewData(bow: bow, stroke: stroke, time: rankedData[i].time)
                runData[i] = updatedCrewData // Replace with updated crew data
            }
            
            crewsData.append(runData) // Append runData for this wave to crewsData
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
