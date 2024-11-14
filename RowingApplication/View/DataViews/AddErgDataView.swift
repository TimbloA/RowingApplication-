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
                    .onChange(of: dataViewModel.distance, initial: true) {
                        generateInputFields()
                    }
            }
            Text("Intervals \(Int(dataViewModel.noOfIntervals))")
            Slider(value:$dataViewModel.noOfIntervals,in:1...20,step:1)
                .onChange(of: dataViewModel.noOfIntervals, initial: true) {
                    generateInputFields()
                }
            
            ScrollView {
                ForEach(0..<$dataViewModel.ergTimes.count, id: \.self) { ergIndex in
                    VStack(alignment: .leading) {
                        
                        Text("Interval \(ergIndex + 1)").font(.headline).padding(.top)
                        VStack {
                            TimeInputView(timeTenths: $dataViewModel.ergTimes[ergIndex].split)
                            
                            HStack {
                                TextField("Distance",text:$dataViewModel.ergTimes[ergIndex].distance)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                Text("m")
                                TextField("Rate",text:$dataViewModel.ergTimes[ergIndex].rate)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                Text("spm")
                            }
                        }
                    }
                }
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
    func generateInputFields() {
        let avgDistance = (Int(dataViewModel.distance) ?? 0)/Int(dataViewModel.noOfIntervals) ?? 1
        
        dataViewModel.ergTimes = Array(repeating: ErgIntervalData(distance: "\(avgDistance)", split: "", rate: ""), count: Int(dataViewModel.noOfIntervals))
   
    }
     
}

#Preview {
    AddErgDataView()
}
