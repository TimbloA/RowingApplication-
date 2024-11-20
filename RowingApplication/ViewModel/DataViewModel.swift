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
    var ergTimes: [ErgIntervalData] = []
    var athlete: String = ""
    var submitEntry: String = "Submit Entry"
    var Notes: String = ""
    var noOfIntervals: Double = 4
    
    func addNewErg() {
        let intDistance = Int(distance) ?? 0
        var time = 0
        for item in ergTimes {
            time += Int(item.split) ?? 0
        }
        var avgRate:Double = 0.0
        for item in ergTimes {
            avgRate += Double(item.rate) ?? 0
        }
        avgRate = avgRate/noOfIntervals
        DataManager.shared.ergData.append(SingleErgData(title: title, athlete: athlete, date: dataDate, distance: intDistance, time: time,ergDataPoints: ergTimes,averageRate: avgRate))
        submitEntry = "Submitted!"
        resetDisplay()
        DataManager.shared.saveData()
    }
    func addNewTraining() {
        let intDistance = Int(distance) ?? 0
        let time = 1.convertToTenths(hours: hours,minutes: minutes,  seconds: seconds, tenths: tenths)
        DataManager.shared.trainingData.append(TrainingData(title: title, date: dataDate, crew: crew, distance: intDistance, time: time,notes: Notes))
        submitEntry = "Submitted!"
        resetDisplay()
        
        DataManager.shared.saveData()
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
        newTraining = false
        ergTimes = []
        noOfIntervals = 4
    }
}
