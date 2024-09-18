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
    var title: String = ""
    var distance: String = ""
    var dataDate: Date = Date()
    
    private init() {
        currErgData = currentErgData.singleExamples
        
    }
//    
//    func addNewErg() {
//      
//       
//        resetDisplay()
//        
//    }
//    func resetDisplay() {
// 
//    }
    
}
