//
//  WeatherData.swift
//  WeatherApp
//
//  Created by doniyor normuxammedov on 22/01/24.
//

import Foundation
//"weather": [
//  {
//    "id": 501,
//    "main": "Rain",
//    "description": "moderate rain",
//    "icon": "10d"
//  }
//],
//"base": "stations",
//"main": {
//  "temp": 298.48,
//  "feels_like": 298.74,
//  "temp_min": 297.56,
//  "temp_max": 300.05,
//  "pressure": 1015,
//  "humidity": 64,
//  "sea_level": 1015,
//  "grnd_level": 933
//},

struct WeatherData: Codable {
    let weather: [Weather]
    let main: MainWeather?
    
}

struct Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    
}

struct MainWeather: Codable {
    let temp: Double?
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
}
                        
