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
        }
        .padding()
    }
}

#Preview {
    ErgDataView(ErgData: SingleErgData(title: "2k", athlete:"Ed Slack",distance: 2000, time: 4121))
}
