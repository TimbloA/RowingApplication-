//
//  AddTrainingDataView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 19/09/2024.
//

import SwiftUI

struct AddTrainingDataView: View {
    @StateObject var dataViewModel: DataViewModel = DataViewModel.shared

    var body: some View{
        VStack{
        
            Text("Enter New Session").frame(maxWidth: .infinity,alignment:.center).font(.title2)
            TextField("Title",text: $dataViewModel.title)
            TextField("Crew",text: $dataViewModel.crew)
            DatePicker(
                "Date:",
                selection: $dataViewModel.dataDate,
                displayedComponents: [.date]
            )
            HStack{
                TextField("Distance",text: $dataViewModel.distance)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("m")
            }
            HStack {
                TextField("Hour",text: $dataViewModel.hours)
                    .keyboardType(.numberPad)
                    .frame(width: 80)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text(":")
                TextField("Minute",text: $dataViewModel.minutes)
                    .keyboardType(.numberPad)
                    .frame(width: 80)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text(":")
                TextField("Second",text: $dataViewModel.seconds)
                    .keyboardType(.numberPad)
                    .frame(width: 80)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text(".")
                TextField("Tenths",text: $dataViewModel.tenths)
                    .keyboardType(.numberPad)
                    .frame(width: 80)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            TextField("Notes",text: $dataViewModel.Notes, axis: .vertical)
                .frame(width: 400)
                .lineLimit(5, reservesSpace: true)
                .textFieldStyle(.roundedBorder)
        
            Section{
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
