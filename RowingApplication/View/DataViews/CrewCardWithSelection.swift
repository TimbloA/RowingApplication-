//
//  CrewCardWithSelection.swift
//  RowingApplication
//
//  Created by Adi Timblo on 05/01/2025.
//

import SwiftUI


struct CrewCardWithSelection: View {
    let title: String
    let crew: Crew?
    @Binding var selectedAthleteIndex: Int?
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            
            if let crew = crew {
                Text(crew.name)
                    .font(.subheadline)
                Text("\(crew.athletes.count) athletes")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                ForEach(Array(crew.athletes.enumerated()), id: \.element.id) { index, athlete in
                    AthleteSelectionRow(
                        athlete: athlete,
                        isSelected: selectedAthleteIndex == index,
                        onTap: {
                            if selectedAthleteIndex == index {
                                selectedAthleteIndex = nil
                            } else {
                                selectedAthleteIndex = index
                            }
                        }
                    )
                }
            } else {
                Text("Tap to create crew")
                    .foregroundColor(.gray)
                    .onTapGesture(perform: onTap)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 150)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
