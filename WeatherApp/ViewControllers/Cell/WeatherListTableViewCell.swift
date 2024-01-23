//
//  WeatherListTableViewCell.swift
//  WeatherApp
//
//  Created by doniyor normuxammedov on 23/01/24.
//

import UIKit

class WeatherListTableViewCell: UITableViewCell {

    @IBOutlet weak var temperatureLB: UILabel!
    @IBOutlet weak var cityNameLB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: WeatherData) {
        cityNameLB.text = data.name.value
        temperatureLB.text = "\(data.currentTemperature?.temperature.value ?? 0.0)"
    }

}
