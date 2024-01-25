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
    private  var  dataSourse: TableViewDataSourse<WeatherListTableViewCell,Entity>!
    private var dbweather: [Entity] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSourse = TableViewDataSourse(cellIdentifier: "weatherCell", items: dbweather, configureCell: { cell,
            data in cell.setData(data: data)})
        weatherTB.dataSource = dataSourse
        weatherTB.delegate = self
        fetchFromDB()
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
        save2DB(data: data)
        fetchFromDB()
        
        weatherTB.reloadData()
    }
    
    func save2DB(data: WeatherData) {
        let weather = Entity(context: self.context)
        weather.name = data.name.value
        weather.temperature = data.currentTemperature?.temperature.value ?? 0.0
        
        do {
            try self.context.save()
        } catch {
            print("Error occured in saving data")
        }
    }
    
    func fetchFromDB() {
        do {
            self.dbweather = try context.fetch(Entity.fetchRequest())
        } catch {
            
        }
        dataSourse.updateItems(dbweather)
    }
    
    func deleteWeather(data: Entity) {
        context.delete(data)
        
        do {
            try self.context.save()
        } catch {
            let error = error as NSError
            print("Error occured when deleting data \(error.localizedDescription)")
        }
    }
}

 extension WeatherListViewController: UITableViewDelegate {
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         let deleteData = deleteData(at: indexPath)
         return UISwipeActionsConfiguration(actions: [deleteData])
     }
     
     func deleteData (at index: IndexPath ) -> UIContextualAction {
         let action = UIContextualAction(style: .destructive, title: "Delete") { action, view,completion in
             let data = self.dbweather [index.row]
             self.dbweather.remove(at: index.row)
             self.dataSourse.updateItems(self.dbweather)
             self.weatherTB.reloadData()
             self.deleteWeather(data: data)
             completion(true)
             action.backgroundColor = .red
         }
         return action
     }
}

extension WeatherListViewController: SettingsDelegate {
    func settingsDdone(vm: SettingsViewModel) {
        weatherViewModel.updateUnit(to: vm.selectedUnit)
        weatherTB.reloadData()
    }
}


