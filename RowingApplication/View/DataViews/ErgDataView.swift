//
//  ErgDataView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 16/09/2024.
//

import SwiftUI

struct ErgDataView: View {
    let ErgData: SingleErgData
    var body: some View {
        VStack {
            
            Form{
                Text("\(ErgData.displayData())")
                        }
            Spacer()
            ScrollView {
                ForEach(0..<ErgData.ergDataPoints.count, id: \.self) { ergIndex in
                    VStack(alignment: .leading) {
                        
                        Text("Interval \(ergIndex + 1)").font(.headline).padding(.top)
                        VStack {
                            Text("Time")
                            Text("\(1.convertTenthsOfSeconds(Int(ErgData.ergDataPoints[ergIndex].split) ?? 1))")
                            HStack{
                                Text("Distance:")
                                Text("\(ErgData.ergDataPoints[ergIndex].distance)")
                                Text("m")
                                Text("Rate")
                                Text("\(ErgData.ergDataPoints[ergIndex].rate)")
                                Text("spm")
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ErgDataView(ErgData: SingleErgData(title: "2k", athlete:"Ed Slack",distance: 2000, time: 4121))
}
