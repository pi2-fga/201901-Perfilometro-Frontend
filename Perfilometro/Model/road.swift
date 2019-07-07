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
    var lazers: [[Int]]
    var locations: [Location]//Location
    
    init(name: String, date: String, lazers: [[Int]], locations: [Location]) {
//        self.identifier = identifier
        self.date = date
        self.name = name
        self.lazers = lazers
        self.locations = locations
    }
    
    init(from item: JSON) {
//        if  let name = data["name"].string,
//            let date = data["date"].string,
//            let lazers = data["lasers"].string,
//            let location = data["locations"].string{
//            self.name = name
//            self.date = date
//            self.lazers = lazers
//            self.locations = location
        let name = item["name"].string
        let date = item["date"].string
        let lazers:[[Int]] = item["lasers"].rawValue as! [[Int]]
        var coordinates_location: [Location] = [Location]()
        
        for location in item["locations"].rawValue as! NSArray {
            let coordinates_raw = location as? NSDictionary
            let latitude = coordinates_raw?["latitude"] as! Double
            let longitude = coordinates_raw?["longitude"] as! Double
            
            let coordenates = Location(latitude: latitude, longitude: longitude)
            coordinates_location.append(coordenates)
        }
        
        self.name = name!
        self.date = date!
        self.lazers = lazers
        self.locations = coordinates_location
//    } else  {
//            self.name = ""
//            self.date = ""
//            self.lazers = ""
//            self.locations = ""
//        }
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
