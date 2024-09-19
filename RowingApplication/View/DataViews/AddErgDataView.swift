//
//  AddDataView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 18/09/2024.
//

import SwiftUI

struct AddErgDataView: View {
    @StateObject var dataViewModel: DataViewModel = DataViewModel.shared

    var body: some View{
        VStack{
        
            Text("Enter New Data").frame(maxWidth: .infinity,alignment:.center).font(.title2)
            TextField("Title",text: $dataViewModel.title)
            TextField("Athlete",text: $dataViewModel.athlete)
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
        
            Section{
                Button(dataViewModel.submitEntry, action: {
                    if dataViewModel.title != "" {
                        dataViewModel.addNewErg()
                    }
                }).font(.title2)
                
            }
            
        }
        .padding()
    }
     
}

#Preview {
    AddErgDataView()
}
