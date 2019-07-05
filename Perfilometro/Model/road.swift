//
//  road.swift
//  Perfilometro
//
//  Created by Geovanni Oliveira de Jesus on 14/06/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation

class Road {
    var identifier: String
    var date: String
    var name: String
    var lazers: [[Int]]
    
    init(identifier: String, date: String, name: String, lazers: [[Int]]) {
        self.identifier = identifier
        self.date = date
        self.name = name
        self.lazers = lazers
    }
    

}
