//
//  TrainingDataListView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 19/09/2024.
//

import SwiftUI

struct TrainingDataListView: View {
    @StateObject var dataViewModel: DataViewModel = DataViewModel.shared
    @State private var searchText: String = ""
    var searchResults: [TrainingData] {
        if searchText.isEmpty {
            return dataViewModel.currTrainingData
        }else  {
            return dataViewModel.currTrainingData.filter { $0.crew.contains(searchText) || $0.title.contains(searchText)}
        }
    }
    var body: some View {
        VStack{
            NavigationStack {
                List {
                    ForEach(searchResults,id: \.self.title) { training in
                        NavigationLink(destination: TrainingDataView(TrainingData:training)){
                            Text("\(training.title) (\(training.crew))")
                        }
                    }
                    .onDelete(perform: deleteItems)
                    Button("Add New Entry"){
                        dataViewModel.newTraining.toggle()
                    }
                }
                .navigationTitle("Training Data")
                .sheet(isPresented: $dataViewModel.newTraining){
                        AddTrainingDataView()
                            .presentationDetents([.medium, .large])
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
    TrainingDataListView()
}
