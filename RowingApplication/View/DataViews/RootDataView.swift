//
//  RootTrainingView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 19/09/2024.
//

import SwiftUI

struct RootDataView: View {
    var single: Bool
    var singleAthlete: String
    enum dataType:String, CaseIterable, Identifiable{
        case Training
        case Erg
        case Pairs
        var id: Self { self }
    }
    @State private var dataChoice:dataType = .Training
    var body: some View {
        VStack{
            Picker("DataType:",selection: $dataChoice) {
                Text("Training").tag(dataType.Training)
                Text("Erg").tag(dataType.Erg)
                Text("Pairs Matrix").tag(dataType.Pairs)
            }
            if dataChoice == .Training{
                TrainingDataListView()
            }else if dataChoice == .Erg{
                ErgDataListView(Single: single, SingleAthlete: singleAthlete)
            }else if dataChoice == .Pairs{
                PairsMatrixDataInputView()
            }
        }
        
            

    }
    
}

#Preview {
    RootDataView(single: false, singleAthlete: "")
}
