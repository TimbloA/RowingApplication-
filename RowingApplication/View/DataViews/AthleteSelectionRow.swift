//
//  AthleteSelectionRow.swift
//  RowingApplication
//
//  Created by Adi Timblo on 18/10/2024.
//

import SwiftUI


struct AthleteSelectionRow: View {
    let athlete: Athlete
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(athlete.name)
                    .font(.caption)
                Text("Side:\(athlete.side.rawValue)")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical, 4)
        .background(isSelected ? Color.blue.opacity(0.1) : Color.clear)
        .cornerRadius(8)
        .onTapGesture(perform: onTap)
    }
}
