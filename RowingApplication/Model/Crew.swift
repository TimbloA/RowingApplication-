//
//  Crew.swift
//  RowingApplication
//
//  Created by Adi Timblo on 22/12/2024.
//

import Foundation

class Crew: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
    var athletes: [Athlete]
    init(name: String, athletes: [Athlete]) {
        self.name = name
        self.athletes = athletes
    }
    static func == (lhs: Crew, rhs: Crew) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    func addAthlete(_ athlete: Athlete) {
        athletes.append(athlete)
    }
    
    func removeAthlete(_ athlete: Athlete) {
        // Removes the athletes with the id we want
        athletes.removeAll { $0.id == athlete.id }
    }

}
