//
//  FetchingStatusView.swift
//  USNWC Trails
//
//  Created by Adam Walsh on 6/20/20.
//  Copyright © 2020 Grid Research. All rights reserved.
//

import SwiftUI

struct FetchingStatusView: View {
    var body: some View {
        ZStack{
            Color(UIColor(hexString: "#292D30")!).edgesIgnoringSafeArea(.all)
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
