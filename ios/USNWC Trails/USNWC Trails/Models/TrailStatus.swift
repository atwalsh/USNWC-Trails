//
//  TrailStatus.swift
//  USNWC Trails
//
//  Created by Adam Walsh on 5/23/20.
//  Copyright © 2020 Grid Research. All rights reserved.
//

import Foundation
import SwiftDate
import SwiftHEXColors
import SwiftUI

struct TrailStatus: Codable {
    static let closedColor = Color(UIColor(hexString: "#C1344B")!)
    static let openColor = Color(UIColor(hexString: "#43914D")!)
    var status: String
    var since: DateInRegion

    private enum CodingKeys: String, CodingKey {
        case since, status
    }

}
