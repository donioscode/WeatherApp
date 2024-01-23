//
//  ViewController.swift
//  WeatherApp
//
//  Created by doniyor normuxammedov on 22/01/24.
//

import UIKit

class WeatherListViewController: UIViewController, AddWeatherDelegate {
   
    @IBOutlet weak var weatherTB: UITableView!
    private lazy var weathersData: [WeatherData] = []
    private  var  dataSourse: TableViewDataSourse<WeatherListTableViewCell,WeatherData>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherTB.delegate = self
        dataSourse = TableViewDataSourse(cellIdentifier: "weatherCell", items: weathersData, configureCell: { cell, data in cell.setData(data: data)})
        weatherTB.dataSource = dataSourse
        // Do any additional setup after loading the view.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddWeatherViewController" {
            guard let nav = segue.destination as? UINavigationController else { return }
            
            guard let addWeatherVC = nav.viewControllers.first as? AddWeatherViewController else { return}
            
            addWeatherVC.delegate = self
        }
    }
    
    func sendWeather(data: WeatherData) {
        print(data)
        weathersData.append(data)
        weatherTB.reloadData()
    }
}

extension WeatherListViewController: UITableViewDelegate {

}
