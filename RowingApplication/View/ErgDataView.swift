//
//  ErgDataView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 16/09/2024.
//

import SwiftUI

struct ErgDataView: View {
    let ErgData: ErgData
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
    ErgDataView(ErgData: ErgData(title: "2k", athlete:currentAthletes.examples[0], distance: 2000))
}
