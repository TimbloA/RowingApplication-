//
//  RootTrainingView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 19/09/2024.
//

import SwiftUI

struct RootDataView: View {
    enum dataType:String, CaseIterable, Identifiable{
        case Training
        case Erg
        var id: Self { self }
    }
    @State private var dataChoice:dataType = .Training
    var body: some View {
        VStack{
            Picker("DataType:",selection: $dataChoice) {
                Text("Training").tag(dataType.Training)
                Text("Erg").tag(dataType.Erg)
            }
            if dataChoice == .Training{
                TrainingDataListView()
            }else if dataChoice == .Erg{
                ErgDataListView(Single: false, SingleAthlete: "")
            }
        }
        
            

    }
    
}

#Preview {
    RootDataView()
}
