//
//  currentData.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 16/09/2024.
//
import Foundation

struct currentData {
    #if DEBUG
    static var ergExamples: [SingleErgData] {
        return DataManager.shared.ergData.isEmpty ? [
            SingleErgData(id: UUID(), title: "2K", athlete: "Ed Slack", distance: 2000),
            SingleErgData(id: UUID(), title: "5K", athlete: "Ed Slack", distance: 5000),
            SingleErgData(id: UUID(), title: "5K", athlete: "Adi Timblo", distance: 5000)
        ] : DataManager.shared.ergData
    }
    
    static var trainingExamples: [TrainingData] {
        return DataManager.shared.trainingData.isEmpty ? [
            TrainingData(id: UUID(), title: "12K UT2", crew: "2nd VIII", distance: 12000, time: 12033, notes: "Slight easterly breeze.")
        ] : DataManager.shared.trainingData
    }
    
    static var pairsMatrixExamples: [PairsMatrix] {
        return DataManager.shared.pairsData.isEmpty ? [
            PairsMatrix(title: "VIII Pairs", data: [
                [
                    CrewData(bow: AthletePair(name: "Henry Clarke", points: 1), stroke: AthletePair(name: "Ed Slack", points: 1), time: 40),
                    CrewData(bow: AthletePair(name: "Nikolai Rybin", points: 2), stroke: AthletePair(name: "Richard Oliverson", points: 2), time: 40),
                    CrewData(bow: AthletePair(name: "George Konig", points: 3), stroke: AthletePair(name: "Charlie Bowker", points: 3), time: 41)
                ],
                [
                    CrewData(bow: AthletePair(name: "Nikolai Rybin", points: 1), stroke: AthletePair(name: "Ed Slack", points: 1), time: 42),
                    CrewData(bow: AthletePair(name: "George Konig", points: 2), stroke: AthletePair(name: "Richard Oliverson", points: 2), time: 42),
                    CrewData(bow: AthletePair(name: "Henry Clarke", points: 3), stroke: AthletePair(name: "Charlie Bowker", points: 3), time: 42)
                ]
            ], athletes: [
                "Ed Slack",
                "Richard Oliverson",
                "Charlie Bowker",
                "Henry Clarke",
                "Nikolai Rybin",
                "George Konig"
            ])
        ] : DataManager.shared.pairsData
    }
    #endif
}
