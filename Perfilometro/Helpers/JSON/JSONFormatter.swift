//
//  JSONFormatter.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 09/07/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation

class JSONFormatter {
    
    public static func setLocationsJSON(json: JSON) -> [CLLocationCoordinate2D] {
        var coordinates = [CLLocationCoordinate2D]()
        let content = json["locations"]
        for item in content.arrayValue {
            if let latitude = item["latitude"].double,
                let longitude = item["longitude"].double {
                let location = CLLocationCoordinate2D(latitude: latitude,
                                                      longitude: longitude)
                coordinates.append(location)
            }
        }
        
        return coordinates
    }
    
    public static func setSensorsJSON(json: JSON) -> [[Float]] {
//        var matrix = [[Int]](x)
        let content = json["lasers"].arrayObject as? [[Float]]
        
        if let content = content {
            return content
        } else {
            return [[]]
        }
    }

}
