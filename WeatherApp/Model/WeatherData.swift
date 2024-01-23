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

struct WeatherData: Decodable {
//    let weather: [Weather]
    let currentTemperature: MainWeather?
    let name: Dynamic<String>
    
    private enum CodingKeys: String, CodingKey {
        case name
//        case weather
        case currentTemperature = "main"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = Dynamic(try container.decode(String.self, forKey: .name))
        currentTemperature = try container.decode(MainWeather.self, forKey: .currentTemperature)
    }
    
}

struct Weather: Decodable {
    let id: Int?
    let main: String?
    let description: String?
    
}

struct MainWeather: Decodable {
    let temperature: Dynamic<Double>
    let feelsLike: Dynamic<Double>
    let temperatureMin: Dynamic<Double>
    let temperatureMax: Dynamic<Double>
    
    init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)
         temperature = Dynamic(try container.decode(Double.self, forKey: .temperature))
         temperatureMin = Dynamic(try container.decode(Double.self, forKey: .temperatureMin))
         temperatureMax = Dynamic(try container.decode(Double.self, forKey: .temperatureMax))
         feelsLike = Dynamic(try container.decode(Double.self, forKey: .feelsLike))
    }
    
    private enum CodingKeys: String , CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
        case feelsLike = "feels_like"
    }
}

class Dynamic<T>: Decodable where T: Decodable {
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        self.listener?(value)
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    private enum CodingKeys: CodingKey {
        case value
    }
}
                        
