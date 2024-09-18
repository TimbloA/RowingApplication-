//
//  AddDataView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 18/09/2024.
//

import SwiftUI

struct AddDataView: View {
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
                TextField("Minute",text: $dataViewModel.minutes)
                    .keyboardType(.numberPad)
                    .frame(width: 100)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text(":")
                TextField("Second",text: $dataViewModel.seconds)
                    .keyboardType(.numberPad)
                    .frame(width: 100)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text(".")
                TextField("Tenths",text: $dataViewModel.tenths)
                    .keyboardType(.numberPad)
                    .frame(width: 100)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        
            Section{
                Button(dataViewModel.submitErg, action: {
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
    AddDataView()
}
