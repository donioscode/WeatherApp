//
//  AddWeatherViewController.swift
//  WeatherApp
//
//  Created by doniyor normuxammedov on 22/01/24.
//

import UIKit

class AddWeatherViewController: UIViewController {

    @IBOutlet weak var cityTF: UITextField!
    private let networking = NetworkingManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        guard let cityName = cityTF.text, !cityName.isEmpty else {
            return
        }
        
        networking.getWeatherData(cityName: cityName) { weatherData in
            if let weatherData = weatherData {
                print(weatherData)
            }
        }
    }
}
