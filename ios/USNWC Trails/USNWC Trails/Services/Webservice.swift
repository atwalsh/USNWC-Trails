//
//  Webservice.swift
//  USNWC Trails
//
//  Created by Adam Walsh on 5/23/20.
//  Copyright © 2020 Grid Research. All rights reserved.
//

import Foundation
import SwiftDate
import SwiftyJSON

class Webservice {
    func getStatus(completion: @escaping (TrailStatus) -> ()) {
        let url = URL(string: "https://us-central1-usnwc-trails.cloudfunctions.net/get-status")
        URLSession.shared.dataTask(with: url!) { data, _, _ in
            let json = try! JSON(data: data!)
            let _status = json["status"].stringValue
            let _since = json["since"].stringValue.toISODate()
            let status = TrailStatus(status: _status, since: _since!)
            DispatchQueue.main.async {
                completion(status)
            }
        }.resume()
    }
}
