//
//  ViewController.swift
//  WeatherApp
//
//  Created by doniyor normuxammedov on 22/01/24.
//

import UIKit

class WeatherListViewController: UIViewController, AddWeatherDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddWeatherViewController" {
            guard let nav = segue.destination as? UINavigationController else { return }
            
            guard let addWeatherVC = nav.viewControllers.first as? AddWeatherViewController else { return}
        }
    }
    
    func sendWeather(data: WeatherData) {
        print(data)
    }
}

