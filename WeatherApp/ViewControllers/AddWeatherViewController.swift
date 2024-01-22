//
//  AddWeatherViewController.swift
//  WeatherApp
//
//  Created by doniyor normuxammedov on 22/01/24.
//

import UIKit
protocol AddWeatherDelegate {
    func sendWeather(data: WeatherData)
}
    

class AddWeatherViewController: UIViewController {

    @IBOutlet weak var cityTF: UITextField!
    private let networking = NetworkingManager()
    lazy var delegate: AddWeatherDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        guard let cityName = cityTF.text, !cityName.isEmpty else {
            return
        }
        
        guard let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=144dcdc9ff9c511f99fc9f54c5b26a99")else {return}
        
        let weatherResource = Resourse<WeatherData>(url: weatherURL) { data in
            let decodeWeatherData = try? JSONDecoder().decode(WeatherData.self, from: data)
            return decodeWeatherData
             
        }
        
        WebService().load(resourse: weatherResource) { result in
            if let data = result {
                self.delegate?.sendWeather(data: data)
                self.dismiss(animated: true,completion: nil)
            }
        }
//        networking.getWeatherData(cityName: cityName) { data in
//            
//            if let data = data {
//                self.delegate?.sendWeather(data: data)
//                self.dismiss(animated: true,completion: nil)
//            }
//        }
    }
}
