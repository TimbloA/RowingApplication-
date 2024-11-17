//
//  RateCheckerView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 17/11/2024.
//

import SwiftUI

struct RateCheckView: View {
    @State private var rateCheck = RateCheck()
       @State private var strokesPerMinute: Double = 0.0
       
       var body: some View {
           VStack(spacing: 20) {
               Text("Strokes Per Minute")
                   .font(.title)
                   .padding()
               
               Text(String(format: "%.2f", strokesPerMinute))
                   .font(.largeTitle)
                   .bold()
               
               Button(action: {
                   // Record a stroke and update the rate
                   rateCheck.recordStroke()
                   strokesPerMinute = rateCheck.strokesPerMinute
               }) {
                   Text("Record Stroke")
                       .font(.title2)
                       .padding()
                       .foregroundColor(.white)
                       .background(Color.blue)
                       .cornerRadius(10)
               }
           }
           .padding()
}
}

#Preview {
    RateCheckView()
}
