//
//  TrainingDataView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 19/09/2024.
//

import SwiftUI

struct TrainingDataView: View {
    let TrainingData: TrainingData
    var body: some View {
        VStack {
            
            Section{
                Text("\(TrainingData.displayData())")
            }
            .padding(.vertical)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    TrainingDataView(TrainingData: TrainingData(title: "12K UT2", crew: "2nd VIII", distance: 12000,time: 12033,notes:"Slight easterly breeze."))
}
