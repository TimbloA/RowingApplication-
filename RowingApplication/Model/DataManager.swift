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
    @Published var athletes: [Athlete] = [] 

    private let ergDataFile = "ergData.json"
    private let trainingDataFile = "trainingData.json"
    private let pairsDataFile = "pairsData.json"
    private let athleteDataFile = "athletes.json" // New file for athletes

    private init() {
        loadData()
    }

    func loadData() {
        ergData = load(from: ergDataFile) ?? []
        trainingData = load(from: trainingDataFile) ?? []
        pairsData = load(from: pairsDataFile) ?? []
        athletes = load(from: athleteDataFile) ?? [] // Load athlete data
    }

    func saveData() {
        save(ergData, to: ergDataFile)
        save(trainingData, to: trainingDataFile)
        save(pairsData, to: pairsDataFile)
        save(athletes, to: athleteDataFile) // Save athlete data
    }

    private func load<T: Codable>(from filename: String) -> [T]? {
        let fileURL = getDocumentsDirectory().appendingPathComponent(filename)
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode([T].self, from: data)
    }

    private func save<T: Codable>(_ data: [T], to filename: String) {
        let fileURL = getDocumentsDirectory().appendingPathComponent(filename)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let encodedData = try? encoder.encode(data) {
            try? encodedData.write(to: fileURL)
        }
    }

    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
