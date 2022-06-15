//
//  CarModel+CoreDataProperties.swift
//  
//
//  Created by Avaneesh on 05/04/22.
//
//

import Foundation
import CoreData


extension CarModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarModel> {
        return NSFetchRequest<CarModel>(entityName: "CarModel")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var ingress: String?
    @NSManaged public var image: String?
    @NSManaged public var dateTime: String?
    @NSManaged public var tags: NSObject?
    @NSManaged public var content: NSObject?
    @NSManaged public var created: Int64
    @NSManaged public var changed: Int64

}
