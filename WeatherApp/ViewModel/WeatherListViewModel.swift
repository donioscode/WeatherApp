//
//  WeatherListViewModel.swift
//  WeatherApp
//
//  Created by doniyor normuxammedov on 25/01/24.
//

import Foundation


class WeatherListViewModel {
    private (set) var weatherData: [WeatherData] = []
    
    func updateUnit (to unit: Unit) {
        switch unit {
        case .celsius:
            toCelsius()
        case .fahrenheit:
            toFahrenheit()
        }
    }
    
    
    func addWeather(data: WeatherData) {
        weatherData.append(data)
    }
    
    func numberOfRows(_section: Int) -> Int {
        return weatherData.count
    }
    
    private func toCelsius () {
        weatherData = weatherData.map { weatherData in
            let weatherModel = weatherData
            weatherModel.currentTemperature?.temperature.value = ((weatherModel.currentTemperature?.temperature.value ?? 0) - 32) * 5/9
            return weatherModel
        }
    }
    
    private func toFahrenheit () {
        weatherData = weatherData.map { weatherData in
            let weatherModel = weatherData
            weatherModel.currentTemperature?.temperature.value = ((weatherModel.currentTemperature?.temperature.value ?? 0) * 5/9) + 32
            return weatherModel
        }
    }
}
