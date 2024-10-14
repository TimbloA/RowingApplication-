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
    @Binding var timeTenths: String

    var body: some View {
        VStack {
            HStack {
                TextField("Hour", text: $hours)
                    .keyboardType(.numberPad)
                    .frame(width: 80)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text(":")
                
                TextField("Minute", text: $minutes)
                    .keyboardType(.numberPad)
                    .frame(width: 80)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text(":")
                
                TextField("Second", text: $seconds)
                    .keyboardType(.numberPad)
                    .frame(width: 80)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text(".")
                
                TextField("Tenths", text: $tenths)
                    .keyboardType(.numberPad)
                    .frame(width: 80)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            // Add the new version of onChange for each text field
            .onChange(of: hours, initial: false) { oldHours, newHours in
                updateTenths(oldValue: oldHours, newValue: newHours)
            }
            .onChange(of: minutes, initial: false) { oldMinutes, newMinutes in
                updateTenths(oldValue: oldMinutes, newValue: newMinutes)
            }
            .onChange(of: seconds, initial: false) { oldSeconds, newSeconds in
                updateTenths(oldValue: oldSeconds, newValue: newSeconds)
            }
            .onChange(of: tenths, initial: false) { oldTenths, newTenths in
                updateTenths(oldValue: oldTenths, newValue: newTenths)
            }
        }
    }

    // Function to convert the time input to tenths of a second and update the binding
    func updateTenths(oldValue: String, newValue: String) {
        // Assuming 1.convertToTenths is a valid method that takes care of the conversion
        timeTenths = String(1.convertToTenths(hours: hours, minutes: minutes, seconds: seconds, tenths: tenths))
    }
}



//#Preview {
//    TimeInputView(
//    )
//}
