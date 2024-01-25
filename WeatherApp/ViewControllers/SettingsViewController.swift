//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by doniyor normuxammedov on 22/01/24.
//

import UIKit

protocol SettingsDelegate {
    func settingsDdone(vm: SettingsViewModel)
}

class SettingsViewController: UIViewController {
    
    private var _settingsViewModel = SettingsViewModel()
    var delegate: SettingsDelegate?


    @IBOutlet weak var settingsTB: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTB.delegate = self
        settingsTB.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let delegate = delegate {
            delegate.settingsDdone(vm: _settingsViewModel)
        }
    }
}

extension SettingsViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _settingsViewModel.units.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        let unit = _settingsViewModel.units[indexPath.row]
        cell.textLabel?.text = unit.displayName
        
        if unit == _settingsViewModel.selectedUnit {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.visibleCells.forEach { cell in
            cell.accessoryType = .none
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            let unit = Unit.allCases[indexPath.row]
            _settingsViewModel.selectedUnit = unit
        }
    }
}
