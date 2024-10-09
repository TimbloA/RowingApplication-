//
//  PairsMatrixListView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 07/10/2024.
//

import SwiftUI

struct PairsMatrixListView: View {
    @StateObject var selectionDataViewModel: SelectionDataViewModel = SelectionDataViewModel.shared
    @State private var searchText: String = ""
    @State var showInputView = false
    var searchResults: [PairsMatrix] {
        if searchText.isEmpty{
            return selectionDataViewModel.currPairsData
        }else{
            return selectionDataViewModel.currPairsData.filter {  $0.title.contains(searchText)}
        }
    }
    var body: some View {
        VStack{
            NavigationStack {
                List {
                    ForEach(searchResults,id: \.self.title) { pairsData in
                        NavigationLink(destination: RankedAthletesPairsMatrixView(PairsData:pairsData)){
                            Text("\(pairsData.title)")
                        }
                    }
                    .onDelete(perform: deleteItems)
                    Button("Add New Entry"){
                        showInputView.toggle()
                    }
                                    
                }
                .navigationTitle("Pairs Data")
                .sheet(isPresented: $showInputView){
                
                    PairsMatrixDataInputView()
                        .presentationDetents([.medium, .large])
                    
                }

            }
                .searchable(text: $searchText)
                
        }
    }
    func deleteItems(at offsets: IndexSet) {
        selectionDataViewModel.currPairsData.remove(atOffsets: offsets)
      }
}

#Preview {
    PairsMatrixListView()
}
