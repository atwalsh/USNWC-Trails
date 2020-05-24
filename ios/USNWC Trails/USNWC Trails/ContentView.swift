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
    
    @ObservedObject var model = TrailStatusViewModel()
    var body: some View {
        ZStack {
            Color(UIColor(hexString: "#292D30")!).edgesIgnoringSafeArea(.all)
            if !model.status.isEmpty {
                (model.status == "open" ? TrailStatus.openColor : TrailStatus.closedColor).edgesIgnoringSafeArea(.all)
                VStack(spacing: 0.0) {
                    Text("Trails \(model.status)")
                        .font(.title)
                        .foregroundColor(.white)
                        .lineSpacing(50)
                        .lineLimit(nil)
                        
                    Text("Since \(model.getFormattedSince())")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding(.top, 5.0)
                }
            } else {
                VStack {
                    Text("Fetching status").font(.title).foregroundColor(.white)
                    
                }
            }
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
