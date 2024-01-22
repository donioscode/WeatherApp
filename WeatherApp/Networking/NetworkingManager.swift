//
//  NetworkingManager.swift
//  WeatherApp
//
//  Created by doniyor normuxammedov on 22/01/24.
//

import Foundation


class NetworkingManager  {
    
    func getWeatherData( cityName: String, handler: @escaping (WeatherData?) ->()) {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=144dcdc9ff9c511f99fc9f54c5b26a99")else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Content-Type":"application/json"]
        
        URLSession.shared.dataTask(with: request) { data,response,error in
            let response = response as? HTTPURLResponse
            
            if let data = data, let response = response, response.statusCode == 200 {
                if let decodeWeatherData = try? JSONDecoder().decode(WeatherData.self, from: data) {
                    DispatchQueue.main.async {
                        handler(decodeWeatherData)
                    }
                    return
                }
            }else {
                handler(nil)
            }
        }.resume()
    }
}
