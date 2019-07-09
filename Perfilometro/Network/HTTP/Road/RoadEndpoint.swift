//
//  RoadEndpoint.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 05/07/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation
import Alamofire

enum RoadEnpoint {
    case getRoads
}

extension RoadEnpoint: Endpoint {
    
    var path: String {
        switch self {
        case .getRoads:
            return "api/roads/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getRoads:
            return .get
        }
    }
}
