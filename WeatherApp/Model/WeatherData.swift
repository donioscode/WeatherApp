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

//"main": {
//  "temp": 298.48,
//  "feels_like": 298.74,
//  "temp_min": 297.56,
//  "temp_max": 300.05,


struct WeatherData: Decodable {
//    let weather: HeadWeather?
    let currentTemperature: MainWeather?
    let name: Dynamic<String>
    
    private enum CodingKeys: String, CodingKey {
        case name
//        case weather = "weather"
        case currentTemperature = "main"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = Dynamic(try container.decode(String.self, forKey: .name))
//        weather =  try container.decode(HeadWeather.self, forKey: .weather)
        currentTemperature = try container.decode(MainWeather.self, forKey: .currentTemperature)
    }
    
    
}



struct HeadWeather: Decodable {
    let id: Dynamic<Int>
    let main: Dynamic<String>
    let description: Dynamic<String>
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = Dynamic(try container.decode(Int.self, forKey: .id))
        main = Dynamic(try container.decode(String.self, forKey: .main))
        description = Dynamic(try container.decode(String.self, forKey: .description))
      
    }
    
    private enum CodingKeys: String , CodingKey {
        case id = "id"
        case main = "main"
        case description = "description"
       
    }
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
                        
