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
    
    
    func calculateRankings(_ wavesData:[[PairsCrewInput]]) {
        crewsData = []
        
        for waveIndex in 0..<wavesData.count {
            var runData: [(AthletePair, AthletePair, Int)] = []
            
            for crewInput in wavesData[waveIndex] {
                // Parse input times
                guard let startTime = Int(crewInput.startTime), let finishTime = Int(crewInput.finishTime) else {
                    continue
                }
                
                let crewTime = finishTime - startTime
                let bow = AthletePair(name: crewInput.bowName,points:  0)
                let stroke = AthletePair(name: crewInput.strokeName,points: 0)
                
                runData.append((bow, stroke, crewTime))
            }
            
            // Sort crews by their times
            let rankedData = runData.sorted(by: { $0.2 < $1.2 })
            
            // Assign points based on ranking
            for i in 0..<rankedData.count {
                var bow = rankedData[i].0
                var stroke = rankedData[i].1
                
                bow.points = i + 1
                stroke.points = i + 1
                
                runData[i] = (bow, stroke, rankedData[i].2)
            }
            crewsData.append(runData)
        }
    }
}
