//
//  TrailStatusViewModel.swift
//  USNWC Trails
//
//  Created by Adam Walsh on 5/23/20.
//  Copyright © 2020 Grid Research. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import SwiftDate

final class TrailStatusViewModel: ObservableObject {
    init() { getStatus() }
    
    @Published var status = String() {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var since = DateInRegion() {
        didSet {
            didChange.send(self)
        }
    }
    
    func getStatus() {
        self.status = ""
        Webservice().getStatus {
            self.status = $0.status
            self.since = $0.since
        }
    }
    
    /// Get formatted `since` variable.
    /// - Returns: Formatted datetime string for `since` in local timezone.
    func getFormattedSince() -> String {
        return self.since.convertTo(timezone: Zones.current).toFormat("MMM d yyyy',' h:mm a")
    }
    
    let didChange = PassthroughSubject<TrailStatusViewModel,Never>()
    
    
}
