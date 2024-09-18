//
//  TimeInputView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 18/09/2024.
//

import SwiftUI

struct TimeInputView: View {
    @State private var dataTime = DataTime()
    
    var body: some View {
        VStack(spacing: 20) {
              Text("Enter Race Time")
                  .font(.largeTitle)
              
              HStack {
                  VStack {
                      Text("Minutes")
                          .font(.caption)
                      TextField("0", value: $dataTime.minutes, formatter: NumberFormatter())
                          .textFieldStyle(RoundedBorderTextFieldStyle())
                          .keyboardType(.numberPad)
                          .frame(width: 50)
                  }
                  
                  VStack {
                      Text("Seconds")
                          .font(.caption)
                      TextField("0", value: $dataTime.seconds, formatter: NumberFormatter())
                          .textFieldStyle(RoundedBorderTextFieldStyle())
                          .keyboardType(.numberPad)
                          .frame(width: 50)
                  }
                  
                  VStack {
                      Text("Tenths")
                          .font(.caption)
                      TextField("0", value: $dataTime.tenths, formatter: NumberFormatter())
                          .textFieldStyle(RoundedBorderTextFieldStyle())
                          .keyboardType(.numberPad)
                          .frame(width: 50)
                  }
              }
              .padding()
              
              Text("Total Time: \(String(format: "%.1f", dataTime.totalSeconds)) seconds")
                  .font(.headline)

              Spacer()
          }
          .padding()
      }
}

struct RaceTimeInputView_Previews: PreviewProvider {
    static var previews: some View {
       TimeInputView()
    }
}
