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
        if searchText.isEmpty && Single == false {
            return dataViewModel.currErgData
        }else if Single == false {
            return dataViewModel.currErgData.filter { $0.athlete.contains(searchText) || $0.title.contains(searchText)}
        }else{
            return dataViewModel.currErgData.filter { $0.athlete.contains(SingleAthlete) || $0.title.contains(searchText)}
        }
    }
    var body: some View {
        VStack{
            NavigationStack {
                List {
                    ForEach(searchResults,id: \.self.title) { erg in
                        NavigationLink(destination: ErgDataView(ErgData:erg)){
                            Text("\(erg.title) (\(erg.athlete))")
                        }
                    }
                    .onDelete(perform: deleteItems)
                    Button("Add New Erg"){
                        dataViewModel.newErg.toggle()
                    }
                }
                .navigationTitle("Erg Data")
                .sheet(isPresented: $dataViewModel.newErg){
                    Form{
                        AddErgDataView()
                            .presentationDetents([.medium, .large])
                        
                    }
                }
            }
                .searchable(text: $searchText)
            
        }
    }
    func deleteItems(at offsets: IndexSet) {
        dataViewModel.currErgData.remove(atOffsets: offsets)
      }
}


#Preview {
    ErgDataListView(Single:false, SingleAthlete: "")
}
