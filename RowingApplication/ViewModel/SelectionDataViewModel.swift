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
    var strokeSideAthletes: [String] = []
    var bowSideAthletes: [String] = []
    var date = Date()
    var bowRanking: [String] = []
    var strokeRanking: [String] = []
    var crewsData:[[(AthletePair, AthletePair, Int)]] = []
    var currPairsData:[PairsMatrix] = []
    
    private init() {
        currPairsData = currentData.pairsMatrixExamples
    }
    
    func addPairsMatrix() {
        currPairsData.append(PairsMatrix(title: dataTitle, data: crewsData))
    }
    
    
    func calculateRankings(_ wavesData: [[PairsCrewInput]]) {
        crewsData = []
        
        // Dictionary to track athletes by name
        var athletesDict: [String: AthletePair] = [:]
        
        for waveIndex in 0..<wavesData.count {
            var runData: [(AthletePair, AthletePair, Int)] = []
            
            for crewInput in wavesData[waveIndex] {
                // Convert input times
                guard let startTime = Int(crewInput.startTime), let finishTime = Int(crewInput.finishTime) else {
                    continue
                }
                
                let crewTime = finishTime - startTime
                
                // Reuse existing bow or create a new one
                let bow: AthletePair
                if let existingBow = athletesDict[crewInput.bowName] {
                    bow = existingBow
                } else {
                    let newBow = AthletePair(name: crewInput.bowName, points: 0)
                    athletesDict[crewInput.bowName] = newBow
                    bow = newBow
                }
                
                // Reuse existing stroke or create a new one
                let stroke: AthletePair
                if let existingStroke = athletesDict[crewInput.strokeName] {
                    stroke = existingStroke
                } else {
                    let newStroke = AthletePair(name: crewInput.strokeName, points: 0)
                    athletesDict[crewInput.strokeName] = newStroke
                    stroke = newStroke
                }
                
                runData.append((bow, stroke, crewTime))
            }
            
            // Sort crews by their times
            let rankedData = runData.sorted(by: { $0.2 < $1.2 })
            
            // Assign points based on ranking
            for i in 0..<rankedData.count {
                var bow = rankedData[i].0
                var stroke = rankedData[i].1
                
                bow.points += i + 1
                stroke.points += i + 1
            }
            
            crewsData.append(rankedData)
        }
    }

    func rankBowAndStrokeAthletes(crewsData: [[(AthletePair, AthletePair, Int)]]) -> ([AthletePair], [AthletePair]) {
        var bowAthleteDict: [String: AthletePair] = [:] // To store unique bow athletes by name
        var strokeAthleteDict: [String: AthletePair] = [:] // To store unique stroke athletes by name

        // Collect unique bow and stroke athletes from crewsData
        for wave in crewsData {
            for crew in wave {
                let bow = crew.0
                let stroke = crew.1
                
                // Check if the bow athlete already exists, if so, add points
                if bowAthleteDict[bow.name] != nil {
                    bowAthleteDict[bow.name]?.points += bow.points // Add points to existing athlete
                } else {
                    bowAthleteDict[bow.name] = bow // Add new athlete
                }

                // Check if the stroke athlete already exists, if so, add points
                if strokeAthleteDict[stroke.name] != nil {
                    strokeAthleteDict[stroke.name]?.points += stroke.points // Add points to existing athlete
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
