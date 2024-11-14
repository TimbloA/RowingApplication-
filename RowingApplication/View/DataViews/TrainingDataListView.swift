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
            return DataManager.shared.trainingData // Directly use training data from DataManager
        } else {
            return DataManager.shared.trainingData.filter {
                $0.crew.contains(searchText) || $0.title.contains(searchText)
            }
        }
    }

    var body: some View {
        VStack {
            NavigationStack {
                List {
                    ForEach(searchResults, id: \.self.id) { training in
                        NavigationLink(destination: TrainingDataView(TrainingData: training)) {
                            Text("\(training.title) (\(training.crew))")
                        }
                    }
                    .onDelete(perform: deleteItems)
                    Button("Add New Entry") {
                        dataViewModel.newTraining.toggle()
                    }
                }
                .navigationTitle("Training Data")
                .searchable(text: $searchText)
                .sheet(isPresented: $dataViewModel.newTraining) {
                    AddTrainingDataView()
                        .presentationDetents([.medium, .large])
                }
            }
            
        }
    }

    func deleteItems(at offsets: IndexSet) {
        // Remove the selected training data from DataManager directly
        DataManager.shared.trainingData.remove(atOffsets: offsets)
        DataManager.shared.saveData() // Save the updated training data
    }
}

#Preview {
    TrainingDataListView()
}
