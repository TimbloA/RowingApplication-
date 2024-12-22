//
//  AddTrainingDataView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 19/09/2024.
//

import SwiftUI

struct AddTrainingDataView: View {
    @StateObject var dataViewModel: DataViewModel = DataViewModel.shared
    var crews: [Crew] = DataManager.shared.crews

    var body: some View {
        VStack {
            Text("Enter New Session")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.title2)

            Section{
                TextField("Title", text: $dataViewModel.title)
                
                
                HStack{
                    Text("Crew:")
                    Spacer()
                    Picker("Crew", selection: $dataViewModel.crew) {
                        Text("No Crew").tag(Crew? (nil)) // Tag for No Crew option
                        ForEach(crews, id: \.id) { crew in
                            Text(crew.name).tag(crew as Crew?) // Tag each crew with it's actual Crew object
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                // Date Picker
                DatePicker(
                    "Date:",
                    selection: $dataViewModel.dataDate,
                    displayedComponents: [.date]
                )
                
                // Distance Input
                HStack {
                    TextField("Distance", text: $dataViewModel.distance)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("m")
                }
                
                // Time Input (Hours, Minutes, Seconds, Tenths)
                HStack {
                    TextField("Hour", text: $dataViewModel.hours)
                        .keyboardType(.numberPad)
                        .frame(width: 80)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text(":")
                    TextField("Minute", text: $dataViewModel.minutes)
                        .keyboardType(.numberPad)
                        .frame(width: 80)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text(":")
                    TextField("Second", text: $dataViewModel.seconds)
                        .keyboardType(.numberPad)
                        .frame(width: 80)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text(".")
                    TextField("Tenths", text: $dataViewModel.tenths)
                        .keyboardType(.numberPad)
                        .frame(width: 80)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                // Notes Field
                TextField("Notes", text: $dataViewModel.Notes, axis: .vertical)
                    .frame(width: 350)
                    .lineLimit(5, reservesSpace: true)
                    .textFieldStyle(.roundedBorder)
            }
            
            // Submit Button
            Section {
                Button(dataViewModel.submitEntry, action: {
                    if dataViewModel.title != "" {
                        dataViewModel.addNewTraining()
                    }
                }).font(.title2)
            }
        }
        .padding()
    }
}

#Preview {
    AddTrainingDataView()
}
