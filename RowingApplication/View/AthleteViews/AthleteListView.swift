//
//  AthleteListView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 12/09/2024.
//

import SwiftUI

struct AthleteListView: View {
    @StateObject var athleteViewModel: AthletesViewModel = AthletesViewModel.shared
    @State private var searchText: String = ""
    var searchResults: [Athlete] {
        if searchText.isEmpty {
            return athleteViewModel.currAthletes
        }else {
            return athleteViewModel.currAthletes.filter { $0.name.contains(searchText)}
        }
    }
    var body: some View {
        VStack{
            NavigationStack {
                List {
                    ForEach(searchResults,id: \.self.id) { athlete in
                        NavigationLink(destination: AthleteView(athlete: athlete)){
                            Text("\(athlete.name)")
                        }
                    }
                    .onDelete(perform: deleteItems)
                    Button("Add New Athlete"){
                        athleteViewModel.newAthlete.toggle()
                    }
                }
                .navigationTitle("Athletes")
                .sheet(isPresented: $athleteViewModel.newAthlete){
                    Form{
                        NewAthleteView()
                            .presentationDetents([.medium, .large])
                    }
                }
            }
            .searchable(text: $searchText)
        }
    }
    func deleteItems(at offsets: IndexSet) {
          athleteViewModel.currAthletes.remove(atOffsets: offsets)
      }
}

#Preview {
    AthleteListView()
}
