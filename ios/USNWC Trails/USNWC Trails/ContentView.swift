//
//  ContentView.swift
//  USNWC Trails
//
//  Created by Adam Walsh on 5/19/20.
//  Copyright © 2020 Grid Research. All rights reserved.
//

import SwiftUI
import SwiftDate
import SwiftHEXColors

struct ContentView: View {
    @EnvironmentObject var trailStatusViewModel: TrailStatusViewModel

    @ViewBuilder
    var body: some View {
        if !self.trailStatusViewModel.status.isEmpty {
            CurrentStatusView()
        } else {
            FetchingStatusView()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
