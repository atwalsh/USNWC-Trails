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
                VStack {
                    Text("Trails \(model.status)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .lineSpacing(50)
                        .lineLimit(nil)
                    Text("Since \(model.getFormattedSince())")
                        .foregroundColor(.white)
                        .padding(.top, 5)
                    Button(action: {
                        self.model.getStatus()
                    }) {
                        Text("Refresh")
                        .fontWeight(.bold)
                        .padding(10)
                        .font(.callout)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 2)
                        )
                            
                    }
                    .padding(.top, 15)
                }
            } else {
                VStack {
                    Text("Fetching status")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Text("Getting the latest trail status...")
                    .foregroundColor(.white)
                    .padding(.top, 5.0)
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
