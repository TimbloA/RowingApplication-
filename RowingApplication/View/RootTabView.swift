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
                          Image(systemName: "person.fill")
                          Text("Athletes")
                      }
            CrewListView()
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Crews")
                }
            CalendarView()
                      .tabItem {
                          Image(systemName: "calendar")
                          Text("Calendar")
                      }
            StopWatchView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("Stop Watch")
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
