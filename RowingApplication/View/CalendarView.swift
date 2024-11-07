//
//  CalendarView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 18/10/2024.
//
import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()
    @ObservedObject var dataManager = DataManager.shared
    
    // Filter erg data based on the selected date
    var filteredErgData: [SingleErgData] {
        dataManager.ergData.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    }
    
    // Filter training data based on the selected date
    var filteredTrainingData: [TrainingData] {
        dataManager.trainingData.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    }
    
    // Filter pairs matrix data based on the selected date
    var filteredPairsData: [PairsMatrix] {
        dataManager.pairsData.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                        .padding(.horizontal)
                }
                
                List {
                    // Display erg data for the selected date
                    Section(header: Text("Erg Data")) {
                        if filteredErgData.isEmpty {
                            Text("No Erg Data for this day.")
                        } else {
                            ForEach(filteredErgData) { erg in
                                VStack(alignment: .leading) {
                                    NavigationLink(destination: ErgDataView(ErgData: erg)) {
                                        Text("\(erg.title) (\(erg.athlete))")
                                    }
                                }
                            }
                        }
                    }
                    
                    // Display training data for the selected date
                    Section(header: Text("Training Data")) {
                        if filteredTrainingData.isEmpty {
                            Text("No Training Data for this day.")
                        } else {
                            ForEach(filteredTrainingData) { training in
                                NavigationLink(destination: TrainingDataView(TrainingData: training)) {
                                    Text("\(training.title) (\(training.crew))")
                                }
                            }
                        }
                    }
                    
                    // Display pairs matrix data for the selected date
                    Section(header: Text("Pairs Matrix Data")) {
                        if filteredPairsData.isEmpty {
                            Text("No Pairs Data for this day.")
                        } else {
                            ForEach(filteredPairsData) { pairsMatrix in
                                NavigationLink(destination: RankedAthletesPairsMatrixView(PairsData: pairsMatrix)) {
                                    Text("\(pairsMatrix.title)")
                                }
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Calendar")
            }
            .padding()
        }
    }
}

#Preview {
    CalendarView()
}
