//
//  DataManager.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 17/10/2024.
//

import Foundation


class DataManager: ObservableObject {
    static let shared = DataManager()

    @Published var ergData: [SingleErgData] = []
    @Published var trainingData: [TrainingData] = []
    @Published var pairsData: [PairsMatrix] = []
    @Published var crewData: [CrewData] = []
    
    private let ergDataKey = "ergData"
    private let trainingDataKey = "trainingData"
    private let pairsDataKey = "pairsData"
    private let crewDataKey = "crewData"

    private init() {
        loadData()
    }

    func loadData() {
        ergData = load(forKey: ergDataKey) ?? []
        trainingData = load(forKey: trainingDataKey) ?? []
        pairsData = load(forKey: pairsDataKey) ?? []
        crewData = load(forKey: crewDataKey) ?? []
    }

    func saveData() {
        save(ergData, forKey: ergDataKey)
        save(trainingData, forKey: trainingDataKey)
        save(pairsData, forKey: pairsDataKey)
        save(crewData, forKey: crewDataKey)
    }

    private func load<T: Codable>(forKey key: String) -> [T]? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode([T].self, from: data)
    }

    private func save<T: Codable>(_ data: [T], forKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
