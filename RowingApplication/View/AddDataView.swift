//
//  AddDataView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 18/09/2024.
//

import SwiftUI

struct AddDataView: View {
    @StateObject var dataViewModel: DataViewModel = DataViewModel.shared
    
    var body: some View{
        VStack{
            Text("Enter New Data").frame(maxWidth: .infinity,alignment:.center).font(.title2)
            
            Section{
                TextField("Title",text: $dataViewModel.title)
                DatePicker(
                    "Date:",
                    selection: $dataViewModel.dataDate,
                    displayedComponents: [.date]
                )
                TextField("Distance",text: $dataViewModel.distance)
                    .keyboardType(.numberPad)
         
            }
        }
        .padding()
    }
     
}

#Preview {
    AddDataView()
}
