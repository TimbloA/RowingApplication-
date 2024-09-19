//
//  DataViewModel.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 18/09/2024.
//

import Foundation

@Observable
class DataViewModel: ObservableObject{
    static let shared = DataViewModel()
    var currErgData: [SingleErgData] = []
    var currTrainingData: [TrainingData] = []
    var newErg: Bool = false
    var crew: String = ""
    var newTraining: Bool = false
    var title: String = ""
    var distance: String = ""
    var dataDate: Date = Date()
    var hours: String = ""
    var minutes: String = ""
    var seconds: String = ""
    var tenths: String = ""
    var athlete: String = ""
    var submitEntry: String = "Submit Entry"
    
    private init() {
        currErgData = currentData.ergExamples
        currTrainingData = currentData.trainingExamples
    }
    
    func addNewErg() {
        let intDistance = Int(distance) ?? 0
        let intHours = Int(hours) ?? 0
        let intMinutes = Int(minutes) ?? 0
        let intSeconds = Int(seconds) ?? 0
        let intTenths = Int(tenths) ?? 0
        let time = convertToTenths(hours: intHours,minutes: intMinutes,  seconds: intSeconds, tenths: intTenths)
        currErgData.append(SingleErgData(title: title, athlete: athlete, date: dataDate, distance: intDistance, time: time))
        submitEntry = "Submitted!"
        resetDisplay()
    }
    func addNewTraining() {
        let intDistance = Int(distance) ?? 0
        let intHours = Int(hours) ?? 0
        let intMinutes = Int(minutes) ?? 0
        let intSeconds = Int(seconds) ?? 0
        let intTenths = Int(tenths) ?? 0
        let time = convertToTenths(hours: intHours,minutes: intMinutes,  seconds: intSeconds, tenths: intTenths)
        currTrainingData.append(TrainingData(title: title, date: dataDate, crew: crew, distance: intDistance, time: time))
        submitEntry = "Submitted!"
        resetDisplay()
    }
    func convertToTenths(hours: Int,minutes: Int, seconds: Int, tenths: Int) -> Int {
        let tenthsFromHours = hours * 36000
        let tenthsFromMinutes = minutes * 600
        let tenthsFromSeconds = seconds * 10
        let totalTenths = tenthsFromHours + tenthsFromMinutes + tenthsFromSeconds + tenths
        return totalTenths
    }
    func resetDisplay() {
        title = ""
        distance = ""
        dataDate = Date()
        crew = ""
        hours = ""
        minutes = ""
        seconds = ""
        tenths = ""
        athlete = ""
        submitEntry = "Submit Entry"
        
    }
}
