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
                
                Section{
                    TextField("Name",text: $athletesViewModel.athleteName)
                    DatePicker(
                        "DOB:",
                        selection: $athletesViewModel.athleteDOB,
                        displayedComponents: [.date]
                    )
                    Stepper(
                                value: $athletesViewModel.athleteWeight,
                                in: athletesViewModel.range1,
                                step: athletesViewModel.step1
                            ) {
                                Text("Weight: \(athletesViewModel.athleteWeight) ")
                            }
                    
                    Stepper(
                            value: $athletesViewModel.athleteHeight,
                            in: athletesViewModel.range2,
                            step: athletesViewModel.step2
                        ) {
                            Text("Height: \(athletesViewModel.athleteHeight) ")
                        }
                    HStack{
                        Text("Side:")
                        Spacer()
                        Picker("Side:",selection: $athletesViewModel.athleteSide) {
                            Text("Bow Side").tag(athleteSide.Bow)
                            Text("Stroke Side").tag(athleteSide.Stroke)
                            Text("Both").tag(athleteSide.Both)
                            Text("Cox").tag(athleteSide.Cox)
                        }
                        
                    }
                }
            }
            .padding()
        Section{
            Button(athletesViewModel.submitName, action: {
                if athletesViewModel.athleteName != "" {
                    athletesViewModel.addNewAthlete()
                }
            }).font(.title2)
            
            
        }
        .padding(.horizontal)
    }
    
}

#Preview {
    NewAthleteView()
}
