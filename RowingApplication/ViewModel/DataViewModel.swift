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
    var athlete: String = ""
    var submitEntry: String = "Submit Entry"
    var Notes: String = ""
    
    
    func addNewErg() {
        let intDistance = Int(distance) ?? 0
        let time = 1.convertToTenths(hours: hours,minutes: minutes,  seconds: seconds, tenths: tenths)
        DataManager.shared.ergData.append(SingleErgData(title: title, athlete: athlete, date: dataDate, distance: intDistance, time: time))
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
        
    }
}
