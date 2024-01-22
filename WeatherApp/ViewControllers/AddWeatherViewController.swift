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
        
        networking.getWeatherData(cityName: cityName) { data in
            
            if let data = data {
                self.delegate?.sendWeather(data: data)
                self.dismiss(animated: true,completion: nil)
            }
        }
    }
}
