//
//  WeatherDetailTableViewCell.swift
//  WeatherApp
//
//  Created by doniyor normuxammedov on 28/01/24.
//
import UIKit

class WeatherDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var idLB: UILabel!
    
    @IBOutlet weak var mainLB: UILabel!
    
    @IBOutlet weak var descriptionLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
