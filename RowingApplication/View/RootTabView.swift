//
//  RootTabView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 18/09/2024.
//

import SwiftUI

struct RootTabView: View {
    
    var body: some View {
        TabView {
              AthleteListView()
                      .tabItem {
                          Image(systemName: "person.3")
                          Text("Athletes")
                      }
            CalendarView()
                      .tabItem {
                          Image(systemName: "calendar")
                          Text("Calendar")
                      }
            RootDataView(single:false, singleAthlete: "")
                      .tabItem {
                          Image(systemName: "line.horizontal.3.decrease.circle.fill")
                          Text("Data")
                          
                      }
            
              }
    }
}

#Preview {
    RootTabView()
}
