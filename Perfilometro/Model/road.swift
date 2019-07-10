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
    let sensor1Values:[Float] = [25.3, 28.37, 25.19, 26.84, 26.79, 24.28, 25.12, 26.42, 28.44, 27.48, 29.94, 23.72, 25.3, 28.37, 25.19, 26.84, 26.79, 24.28, 25.12, 26.42, 28.44, 27.48, 29.94, 23.72, 25.36, 24.74, 26.21, 28.28, 23.93, 29.32, 24.01, 22.48, 26.54, 25.22, 28.25, 28.81]
    let sensor2Values:[Float] = [25.36, 24.74, 26.21, 28.28, 23.93, 29.32, 24.01, 22.48, 26.54, 25.22, 28.25, 28.81, 25.36, 24.74, 26.21, 28.28, 23.93, 29.32, 24.01, 22.48, 26.54, 25.22, 28.25, 28.81,25.36, 24.74, 26.21, 28.28, 23.93, 29.32, 24.01, 22.48, 26.54, 25.22, 28.25, 28.81]
//    var lazers: [[Float]]
//    var locations: [Location]//Location
    
//    init(name: String, date: String, lazers: [[Float]], locations: [Location]) {
////        self.identifier = identifier
//        self.date = date
//        self.name = name
//        self.lazers = lazers
//        self.locations = locations
//    }
    
    init(name:String, date: String) {
        self.name = name
        self.date = date
    }
    
//    init(from item: JSON) {
////        if  let name = data["name"].string,
////            let date = data["date"].string,
////            let lazers = data["lasers"].string,
////            let location = data["locations"].string{
////            self.name = name
////            self.date = date
////            self.lazers = lazers
////            self.locations = location
//        let name = item["name"].string
//        let date = item["date"].string
//        let lazers:[[Float]] = item["lasers"].rawValue as! [[Float]]
//        var coordinates_location: [Location] = [Location]()
//        
//        for location in item["locations"].rawValue as! NSArray {
//            let coordinates_raw = location as? NSDictionary
//            let latitude = coordinates_raw?["latitude"] as! Double
//            let longitude = coordinates_raw?["longitude"] as! Double
//            
//            let coordenates = Location(latitude: latitude, longitude: longitude)
//            coordinates_location.append(coordenates)
//        }
//        
//        self.name = name!
//        self.date = date!
//        self.lazers = lazers
//        self.locations = coordinates_location
////    } else  {
////            self.name = ""
////            self.date = ""
////            self.lazers = ""
////            self.locations = ""
////        }
//    }
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
