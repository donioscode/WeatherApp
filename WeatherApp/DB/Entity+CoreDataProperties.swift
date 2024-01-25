//
//  Entity+CoreDataProperties.swift
//  WeatherApp
//
//  Created by doniyor normuxammedov on 25/01/24.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var name: String?
    @NSManaged public var temperature: Double

}

extension Entity : Identifiable {

}
