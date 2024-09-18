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
    var newErg: Bool = false
    var title: String = ""
    var distance: String = ""
    var dataDate: Date = Date()
    var minutes: String = ""
    var seconds: String = ""
    var tenths: String = ""
    var athlete: String = ""
    var submitErg: String = "Submit Erg"
    
    private init() {
        currErgData = currentErgData.singleExamples
        
    }
    func addNewErg() {
        let intDistance = Int(distance) ?? 0
        let intMinutes = Int(minutes) ?? 0
        let intSeconds = Int(seconds) ?? 0
        let intTenths = Int(tenths) ?? 0
        let time = convertToTenths(minutes: intMinutes,  seconds: intSeconds, tenths: intTenths)
        currErgData.append(SingleErgData(title: title, athlete: athlete, date: dataDate, distance: intDistance, time: time))
        submitErg = "Submitted!"
        resetDisplay()
      
        
    }
    func convertToTenths(minutes: Int, seconds: Int, tenths: Int) -> Int {
        let tenthsFromMinutes = minutes * 600
        let tenthsFromSeconds = seconds * 10
        let totalTenths = tenthsFromMinutes + tenthsFromSeconds + tenths
        return totalTenths
    }
    func resetDisplay() {
        title = ""
        distance = ""
        dataDate = Date()
        minutes = ""
        seconds = ""
        tenths = ""
        athlete = ""
        submitErg = "Submit Erg"
    }
}
