//
//  WeatherEntity+CoreDataProperties.swift
//  WeatherApp
//
//  Created by doniyor normuxammedov on 29/01/24.
//
//

import Foundation
import CoreData


extension WeatherEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherEntity> {
        return NSFetchRequest<WeatherEntity>(entityName: "WeatherEntity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var main: String?
    @NSManaged public var descriptionn: String?

}

extension WeatherEntity : Identifiable {

}
