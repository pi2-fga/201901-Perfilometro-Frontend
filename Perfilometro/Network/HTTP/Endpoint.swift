//
//  Endpoint.swift
//  Perfilometro
//
//  Created by Miguel Pimentel on 19/05/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation
import Alamofire

enum EndPointHeaders: String {
    case contentType = "application/json"
}

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var fullURL: String { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var body: Parameters { get }
    var headers: HTTPHeaders { get }
}

extension Endpoint {
    
    var baseURL: String {
        return "https://gateway.marvel.com"
    }
    
    var encoding: ParameterEncoding {
        return method == .get ? URLEncoding.default : JSONEncoding.default
    }
    
    var fullURL: String {
        return baseURL + path
    }
    
    var headers: HTTPHeaders {
        return [ "Content-Type": EndPointHeaders.contentType.rawValue]
    }
    
    var body: Parameters {
        return Parameters()
    }
}




