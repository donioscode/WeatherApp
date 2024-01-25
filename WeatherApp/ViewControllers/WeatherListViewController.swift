//
//  ViewController.swift
//  WeatherApp
//
//  Created by doniyor normuxammedov on 22/01/24.
//

import UIKit

class WeatherListViewController: UIViewController, AddWeatherDelegate {
   
    @IBOutlet weak var weatherTB: UITableView!
    
    private var weatherViewModel = WeatherListViewModel()
    private  var  dataSourse: TableViewDataSourse<WeatherListTableViewCell,WeatherData>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSourse = TableViewDataSourse(cellIdentifier: "weatherCell", items: weatherViewModel.weatherData, configureCell: { cell, data in cell.setData(data: data)})
        weatherTB.dataSource = dataSourse
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddWeatherViewController" {
            guard let nav = segue.destination as? UINavigationController else { return }
            
            guard let addWeatherVC = nav.viewControllers.first as? AddWeatherViewController else { return}
            
            addWeatherVC.delegate = self
        } else if segue.identifier == "SettingsViewController" {
            guard let nav = segue.destination as? UINavigationController else { return }
            
            guard let addWeatherVC = nav.viewControllers.first as? SettingsViewController else { return}
            
            addWeatherVC.delegate = self
        }
    }
    
    func sendWeather(data: WeatherData) {
        print(data)
        weatherViewModel.addWeather(data: data)
        dataSourse.updateItems(weatherViewModel.weatherData)
        weatherTB.reloadData()
    }
}

extension WeatherListViewController: SettingsDelegate {
    func settingsDdone(vm: SettingsViewModel) {
        weatherViewModel.updateUnit(to: vm.selectedUnit)
        weatherTB.reloadData()
    }
}
