//
//  CurrentStatusView.swift
//  USNWC Trails
//
//  Created by Adam Walsh on 6/20/20.
//  Copyright © 2020 Grid Research. All rights reserved.
//

import SwiftUI

struct CurrentStatusView: View {
    @State var showingModal = false
    @EnvironmentObject var trailStatusViewModel: TrailStatusViewModel
    
    // Modal
    struct DetailView: View {
        var body: some View {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("About 🚵🏻‍♂️")
                        .font(.title)
                        .padding()
                    Spacer()
                }
                Text("Use this application to check the status of the USNWC trail system, and to access helpful resources for visiting the USNWC.")
                    .padding(.horizontal)
                    .padding(.bottom)
                Divider()
                HStack {
                    Text("Resources")
                        .font(.title)
                        .padding()
                    Spacer()
                }
                Button("USNWC Website ↗") {UIApplication.shared.open(URL(string: "https://usnwc.org")!)}
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                Button("Trail Map ↗") {UIApplication.shared.open(URL(string: "https://usnwc.org/wp-content/uploads/2020/03/2019_USNWC_TrailMap_48x72-01.jpg")!)}
                    .padding(.horizontal)
                Spacer()
                Text("This application is not affiliated with or supported by the U.S. National Whitewater Center (USNWC).")
                .padding()
                    .padding(.horizontal, 30)
                .font(.footnote)
                .multilineTextAlignment(.center)
            }
        }
    }
    
    var body: some View {
        ZStack {
            // Set background color
            (self.trailStatusViewModel.status == "open" ? TrailStatus.openColor : TrailStatus.closedColor)
                .edgesIgnoringSafeArea(.all)
            // Content
            VStack {
                Text("Trails \(self.trailStatusViewModel.status)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .lineSpacing(50)
                    .lineLimit(nil)
                Text("Since \(self.trailStatusViewModel.getFormattedSince())")
                    .foregroundColor(.white)
                    .padding(.top, 5)
                Button(action: {
                    self.trailStatusViewModel.getStatus()
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
                    .fixedSize()
                }
                    .padding(.top, 15)
            }
            // Info button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        self.showingModal.toggle()
                    }) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.white)
                            .padding(.leading)
                            .imageScale(.large)
                    }.sheet(isPresented: $showingModal) {
                        DetailView()
                    }
                    .padding(.trailing, 20.0)
                }
            }
        }
    }
}
