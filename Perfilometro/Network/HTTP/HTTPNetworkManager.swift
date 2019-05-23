//
//  HTTPNetworkManager.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 19/05/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation
import Alamofire


class NetworkManager {
    
    private let manager = Alamofire.Session.default
    static let shared = NetworkManager()

    func request(endpoint: Endpoint, completion: @escaping (DataResponse<Any>) -> Void) {
        manager.request(endpoint.fullURL, method: endpoint.method, parameters: endpoint.body, encoding: endpoint.encoding, headers: endpoint.headers).responseJSON { response in
            completion(response)
        }
    }
}
