//
//  TimeInputView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 10/10/2024.
//

import SwiftUI

struct TimeInputView: View {
    @State var hours = ""
    @State var minutes = ""
    @State var seconds = ""
    @State var tenths = ""
    @Binding var timeTenths:String
    var body: some View {
        VStack {
            HStack {
                TextField("Hour",text: $hours)
                    .keyboardType(.numberPad)
                    .frame(width: 80)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text(":")
                TextField("Minute",text: $minutes)
                    .keyboardType(.numberPad)
                    .frame(width: 80)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text(":")
                TextField("Second",text: $seconds)
                    .keyboardType(.numberPad)
                    .frame(width: 80)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text(".")
                TextField("Tenths",text: $tenths)
                    .keyboardType(.numberPad)
                    .frame(width: 80)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Button("Submit Time", action:{
                timeTenths = String(1.convertToTenths(hours: hours, minutes: minutes, seconds: seconds, tenths: tenths))
            })
        }
    }
}

//#Preview {
//    TimeInputView(
//    )
//}
