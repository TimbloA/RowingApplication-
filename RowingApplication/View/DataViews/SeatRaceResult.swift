//
//  SeatRaceResult.swift
//  RowingApplication
//
//  Created by Adi Timblo on 12/01/2025.
//

import SwiftUI

struct SeatRaceResult: View {
    let SeatRaceData: SeatRace
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(SeatRaceData.title)")
                .font(.title)
                .padding(.horizontal)
            Text("Date: \(SeatRaceData.dataDate.formatDate(date:SeatRaceData.dataDate))")
            Text("Results")
                .font(.headline)
                .padding(.horizontal)
            
            ForEach(SeatRaceData.data, id: \.self) { result in
                Text(result)
                    .padding(.horizontal)
            }
            
            
            
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

//#Preview {
//    SeatRaceResult()
//}
