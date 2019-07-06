//
//  road.swift
//  Perfilometro
//
//  Created by Geovanni Oliveira de Jesus on 14/06/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import Foundation
import SwiftyJSON



class Road {
//    var identifier: String
    var date: String
    var name: String
//    var lazers: [[Int]]
    
    init(name: String, date: String) {
//        self.identifier = identifier
        self.date = date
        self.name = name
//        self.lazers = lazers
    }
    
    init(from data: JSON) {
        if  let name = data["name"].string,
            let date = data["date"].string {
            self.name = name
            self.date = date
        } else  {
            self.name = ""
            self.date = ""
        }
    }
}

//var name: String
//var description: String
//var imageUrl: String
//var comics: Int
//var events: Int
//var stories: Int
//
//init(name: String, description: String, imageUrl: String, comics: Int, events: Int, stories: Int) {
//    self.name = name
//    self.description = description
//    self.imageUrl = imageUrl
//    self.comics = comics
//    self.events = events
//    self.stories = stories
//}
//
//init(data: JSON) {
//    if let name =  data["name"].string,
//        let imagePath = data["thumbnail"]["path"].string,
//        let description = data["description"].string,
//        let imageType = data["thumbnail"]["extension"].string,
//        let comics = data["comics"]["available"].int,
//        let stories = data["comics"]["available"].int,
//        let events = data["comics"]["available"].int {
//        self.name = name
//        self.description = description
//        self.imageUrl = imagePath + "." + imageType
//        self.comics = comics
//        self.events = events
//        self.stories = stories
//    } else {
//        self.name = ""
//        self.description = ""
//        self.imageUrl = ""
//        self.comics = -1
//        self.events = -1
//        self.stories = -1
//    }
//}
