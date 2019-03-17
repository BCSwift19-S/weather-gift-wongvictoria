//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Victoria Wong on 3/16/19.
//  Copyright © 2019 Victoria Wong. All rights reserved.
//

import Foundation
import Alamofire

class WeatherLocation {
    var name = ""
    var coordinates = ""
    
    func getWeather() {
        let weatherURL = urlBase + urlAPIKey + coordinates
        print(weatherURL)
        
        AF.request(weatherURL).responseJSON { response in
            print(response)
        }
    }
}

