//
//  DataListView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 16/09/2024.
//

import SwiftUI

struct DataListView: View {
    @StateObject var ErgViewModel: ErgViewModel = ErgViewModel.shared
    @State private var searchText: String = ""
    var searchResults: [Athlete] {
        if searchText.isEmpty {
            return ErgViewModel.currAthletes
        }else {
            return ErgViewModel.currAthletes.filter { $0.name.contains(searchText)}
        }
    }
    var body: some View {
        VStack{
            NavigationStack {
                List {
                    ForEach(searchResults,id: \.self.name) { athlete in
                        NavigationLink(destination: AthleteView(athlete: athlete)){
                            Text("\(athlete.name)")
                        }
                    }
                    .onDelete(perform: deleteItems)
                    Button("Add New Athlete"){
                        ErgViewModel.newAthlete.toggle()
                    }
                }
                .navigationTitle("Athletes")
                .sheet(isPresented: $ErgViewModel.newAthlete){
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
