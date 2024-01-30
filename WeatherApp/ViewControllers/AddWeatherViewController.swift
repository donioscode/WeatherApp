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
        
        guard let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=144dcdc9ff9c511f99fc9f54c5b26a99&units=imperial")else {return}
        
       
        
        let weatherResource = Resourse<WeatherData>(url: weatherURL) { [weak self] data in
            guard let self else  { return nil }
            do {
                let decodeWeatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                return decodeWeatherData
            } catch let error {
                print(error)
                showError(error.localizedDescription)
                return nil
            }
            
        }
     
        WebService().load(resourse: weatherResource) { result in
            if let data = result {
                self.delegate?.sendWeather(data: data)
                self.dismiss(animated: true,completion: nil)
            }
        }
    }
    private func showError(_ string: String) {
        let alertVC = UIAlertController(title: "Error occurred", message: string, preferredStyle: .alert)
        let action = UIAlertAction(title: "Hide", style: .cancel)
        
        alertVC.addAction(action)
        self.present(alertVC, animated: true)
    }

}
