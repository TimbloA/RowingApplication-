//
//  PairsMatrixDataView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 02/10/2024.
//

import SwiftUI

struct PairsMatrixDataView: View {
    @State private var dummy:String = ""
    var body: some View {
        VStack{
                TextField("Bow",text: $dummy)
                TextField("Stroke",text: $dummy)
        }
        .padding()
    }
    
    
}

#Preview {
    PairsMatrixDataView()
}
