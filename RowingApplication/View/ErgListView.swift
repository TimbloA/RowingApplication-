//
//  ErgListView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 18/09/2024.
//

import SwiftUI

struct ErgListView: View {
    var Ergs:[MultipleErgData] = currentErgData.multipleExamples
    var body: some View {
        Form{
            ForEach(Ergs.allErgs,id: \.self.title) { erg in
                NavigationLink(destination: ErgDataView(ErgData: erg)){
                    Text("\(erg.title)")
                }
            }
        }
    }
}

#Preview {
    ErgListView()
}
