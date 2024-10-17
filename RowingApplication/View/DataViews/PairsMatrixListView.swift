//
//  PairsMatrixListView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 07/10/2024.
//
import SwiftUI

struct PairsMatrixListView: View {
    @StateObject var selectionDataViewModel: SelectionDataViewModel = SelectionDataViewModel.shared
    @ObservedObject var dataManager = DataManager.shared // Observe the DataManager
    @State private var searchText: String = ""
    @State var showInputView = false
    @State var singleAthlete: String
    @State var isSingle: Bool
    
    // Search results based on the filter
    var searchResults: [PairsMatrix] {
        if isSingle {
            return dataManager.pairsData.filter {
                $0.athletes.contains(singleAthlete)
            }
        } else if !searchText.isEmpty {
            return dataManager.pairsData.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) || // Case insensitive search
                $0.athletes.contains(where: { $0.localizedCaseInsensitiveContains(searchText) })
            }
        } else {
            return dataManager.pairsData
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    if searchResults.isEmpty {
                        Text("No Pairs Data Available")
                            .foregroundColor(.gray)
                            .italic()
                    } else {
                        ForEach(searchResults, id: \.self.id) { pairsData in
                            NavigationLink(destination: RankedAthletesPairsMatrixView(PairsData: pairsData)) {
                                Text(pairsData.title)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }

                    // Button to add a new entry
                    Button("Add New Entry") {
                        showInputView.toggle()
                    }
                }
            }
            .navigationTitle("Pairs Data") // Ensure this is inside NavigationStack
            .searchable(text: $searchText) // Search bar
            .sheet(isPresented: $showInputView) {
                PairsMatrixDataInputView()
                    .presentationDetents([.medium, .large])
            }
        }
    }

    // Function to delete selected items
    func deleteItems(at offsets: IndexSet) {
        // Remove the selected pairs data directly from DataManager
        dataManager.pairsData.remove(atOffsets: offsets)
        dataManager.saveData() // Save the updated pairs data
    }
}

#Preview {
    PairsMatrixListView(singleAthlete: "", isSingle: false)
}
