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
                          Image(systemName: "carrot")
                          Text("Athletes")
                      }
                  DataListView(Single:false, SingleAthlete: "")
                      .tabItem {
                          Image(systemName: "fork.knife")
                          Text("Data")
                      }
              }
    }
}

#Preview {
    RootTabView()
}
