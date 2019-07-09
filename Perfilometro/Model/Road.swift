//
//  road.swift
//  Perfilometro
//
//  Created by Geovanni Oliveira de Jesus on 14/06/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation

class Road {

    var date: String
    var name: String
    var locations: [CLLocationCoordinate2D]
    var lasers: [[Int]]

    init(with data: JSON, locations: [CLLocationCoordinate2D], lasers: [[Int]]) {
        if  let name = data["name"].string,
            let date = data["date"].string {
            self.name = name
            self.date = date
            self.locations = locations
            self.lasers = lasers
        } else  {
            self.name = ""
            self.date = ""
            self.locations = [CLLocationCoordinate2D]()
            self.lasers = [[Int]]()
        }
    }
    
}
