//
//  HostingController.swift
//  USNWC Trails
//
//  Created by Adam Walsh on 5/24/20.
//  Copyright © 2020 Grid Research. All rights reserved.
//

import Foundation
import SwiftUI

class HostingController<ContentView> : UIHostingController<ContentView> where ContentView : View {
    override dynamic open var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
