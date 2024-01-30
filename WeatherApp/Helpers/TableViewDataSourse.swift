//
//  TableViewDataSourse.swift
//  WeatherApp
//
//  Created by doniyor normuxammedov on 23/01/24.
//

import Foundation
import UIKit

class TableViewDataSourse<CellType, Data>: NSObject, UITableViewDataSource where CellType: UITableViewCell {
   
    let cellIdentifier : String
    var items: [Data]
    let configureCell : (CellType, Data) -> ()
    
    init(cellIdentifier: String, items: [Data], configureCell: @escaping (CellType, Data) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func updateItems(_ items: [Data]) {
        self.items = items
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CellType
        else {
            fatalError("Cell not found ")
        }
        
        let data = items[indexPath.row]
        configureCell(cell,data)
        return cell
    }
}

