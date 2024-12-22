//
//  CrewRowView.swift
//  RowingApplication
//
//  Created by Adi Timblo on 22/12/2024.
//

import SwiftUI

struct CrewRowView: View {
    let crew: Crew
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(crew.name)
                .font(.headline)
            Text("\(crew.athletes.count) athletes")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

//#Preview {
//    CrewRowView()
//}
