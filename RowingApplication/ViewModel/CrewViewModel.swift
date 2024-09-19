//
//  CrewViewModel.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 19/09/2024.
//

import Foundation

@Observable
class CrewViewModel: ObservableObject{
    static let shared = CrewViewModel()
    var currCrews: [Crew]
    var crewName: crews = .VIII
    var crewAthletes: [String]
    private init() {
        currCrews = currentData.crewExamples
    }
}
