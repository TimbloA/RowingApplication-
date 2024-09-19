//
//  Crew.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 19/09/2024.
//

import Foundation


enum crews: String, CaseIterable, Identifiable {
    case VIII = "The VIII"
    case SecondVIII = "Second VIII"
    case ThirdVIII = "Third VIII"
    case ColtsA = "Colts A"
    
    var id: Self { self }
}

struct Crew{
    var name: crews
    var athletes: [String]
    
    mutating func addAthlete(athlete:String,currAthletes: [String]){
        if !athletes.contains(athlete) {
            athletes.append(athlete)
        }
    }
    
   
}
