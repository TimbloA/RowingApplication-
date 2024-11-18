//
//  DataListView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 18/09/2024.
//



import SwiftUI

struct ErgDataListView: View {
    @StateObject var dataViewModel: DataViewModel = DataViewModel.shared
    @State private var searchText: String = ""
    @State var Single: Bool
    @State var SingleAthlete: String

    var searchResults: [SingleErgData] {
        let ergData = DataManager.shared.ergData // Directly use the data from DataManager
        
        if searchText.isEmpty && Single == false {
            return ergData
        } else if Single == false {
            return ergData.filter { $0.athlete.contains(searchText) || $0.title.contains(searchText) }
        } else {
            return ergData.filter { $0.athlete.contains(SingleAthlete) || $0.title.contains(searchText) }
        }
    }

    var body: some View {
        VStack {
            NavigationStack {
                List {
                    if searchResults.isEmpty {
                        Text("No Erg Data Available")
                            .foregroundColor(.gray)
                            .italic()
                    }else{
                        ForEach(searchResults, id: \.self.id) { erg in
                            NavigationLink(destination: ErgDataView(ErgData: erg)) {
                                Text("\(erg.title) (\(erg.athlete))")
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }

                    Button("Add New Erg") {
                        dataViewModel.newErg.toggle()
                    }
                }
                .navigationTitle("Erg Data")
                .searchable(text: $searchText)
                .sheet(isPresented: $dataViewModel.newErg) {
                    AddErgDataView()
                        .presentationDetents([.medium, .large])
                }
            }
            
        }
    }

    func deleteItems(at offsets: IndexSet) {
        // Remove from the DataManager's ergData directly
        DataManager.shared.ergData.remove(atOffsets: offsets)
        
        // Save the changes
        DataManager.shared.saveData()
    }
}

#Preview {
    ErgDataListView(Single: false, SingleAthlete: "")
}
