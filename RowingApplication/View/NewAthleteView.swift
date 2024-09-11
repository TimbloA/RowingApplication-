//
//  NewAthleteView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 11/09/2024.
//

import SwiftUI
struct NewAthleteView: View {
    @State private var athletesViewModel = AthletesViewModel.shared
  
    var body: some View {
  
    
            VStack{
                Text("Enter New Athlete").frame(maxWidth: .infinity,alignment:.center).font(.title2)
                TextField("Name",text: $athletesViewModel.athleteName)
                Section{
                    //                    Stepper(
                    //                        value: $athletesViewModel.athleteWeight,
                    //                        in: athletesViewModel.range,
                    //                        step: athletesViewModel.step
                    //                    ) {
                    //                        Text("Quantity: \(athletesViewModel.athleteWeight) ")
                    //                    }
                    //                Stepper(
                    //                    value: $athletesViewModel.athleteHeight,
                    //                    in: athletesViewModel.range,
                    //                    step: athletesViewModel.step
                    //                ) {
                    //                    Text("Quantity: \(athletesViewModel.athleteGeight) ")
                    //                }
                    
                    Picker("Side:",selection: $athletesViewModel.athleteSide) {
                        Text("Bow Side").tag(athleteSide.BowSide)
                        Text("Stroke Side").tag(athleteSide.StrokeSide)
                        Text("Both").tag(athleteSide.Both)
                        
                    }
                    
                    DatePicker(
                        "Expiry Date:",
                        selection: $athletesViewModel.athleteDOB,
                        displayedComponents: [.date]
                    )
                }
                
                
            }
        
        
 
        Section{
            Button(athletesViewModel.submitName, action: {
                if athletesViewModel.athleteName != "" {
                    athletesViewModel.addNewIngredient()
                }
            }).font(.title2)
            
            
        }

    }
    
}

#Preview {
    NewAthleteView()
}
