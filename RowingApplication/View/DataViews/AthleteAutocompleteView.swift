//
//  AthleteAutocompleteView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 18/10/2024.
//

import SwiftUI



struct AthleteAutocompleteView: View {
    @Binding var searchText: String
    var filteredAthletes: [Athlete]
    var onSelect: (Athlete) -> Void

    var body: some View {
        if !searchText.isEmpty && !filteredAthletes.isEmpty {
            List(filteredAthletes, id: \.id) { athlete in
                Button(action: {
                    onSelect(athlete) // Pass selected athlete back to the main view
                }) {
                    Text(athlete.name)
                }
                .buttonStyle(PlainButtonStyle()) // Makes button look like a normal text
            }
            .frame(height: 100)
            .listStyle(PlainListStyle())
            .padding(.bottom)
        }
    }
}



//#Preview {
//    AthleteAutocompleteView()
//}
