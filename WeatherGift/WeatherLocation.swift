//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Victoria Wong on 3/25/19.
//  Copyright © 2019 Victoria Wong. All rights reserved.
//

import Foundation

class WeatherLocation: Codable{
    var name = ""
    var coordinates = ""
    
    init(name: String, coordinates: String) {
        self.name = name
        self.coordinates = coordinates
    }
}
