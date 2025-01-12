//
//  SeatRacingListView.swift
//  RowingApplication
//
//  Created by Adi Timblo on 12/01/2025.
//

import SwiftUI

struct SeatRacingListView: View {
    @State private var searchText: String = ""
    @State private var newSeatRace: Bool = false
    var searchResults: [SeatRace] {
        let seatRacingData = DataManager.shared.seatRaces //directly use the data from DataManager
        
        if searchText.isEmpty{
            return seatRacingData
        }else {
            return seatRacingData.filter { $0.title.contains(searchText) }
        }
    }
    
    var body: some View {
        VStack{
            NavigationStack {
                List {
                    if searchResults.isEmpty {
                        Text("No Seat Race Data Available")
                            .foregroundColor(.gray)
                            .italic()
                    }else{
                        ForEach(searchResults, id: \.self.id) { seatRace in
                            NavigationLink(destination: SeatRaceResult(SeatRaceData: seatRace)) {
                                Text("\(seatRace.title)")
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }

                    Button("Add New Seat Race") {
                        newSeatRace.toggle()
                    }
                }
                .navigationTitle("Seat Race Data")
                .searchable(text: $searchText)
                .sheet(isPresented: $newSeatRace) {
                    SeatRacingView()
                        .presentationDetents([.large])
                }
            }
        }
    }
    func deleteItems(at offsets: IndexSet) {
        // Remove from the DataManager's ergData directly
        DataManager.shared.seatRaces.remove(atOffsets: offsets)
        
        // Save the changes
        DataManager.shared.saveData()
    }
}

#Preview {
    SeatRacingListView()
}
