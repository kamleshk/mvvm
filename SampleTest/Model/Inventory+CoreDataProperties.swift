//
//  Inventory+CoreDataProperties.swift
//  SampleTest
//
//  Created by Kamalesh Kumar Yadav on 02/03/19.
//  Copyright © 2019 Kamlesh Kumar. All rights reserved.
//
//

import Foundation
import CoreData


extension Inventory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Inventory> {
        return NSFetchRequest<Inventory>(entityName: "Inventory")
    }

    @NSManaged public var source: String?
    @NSManaged public var destination: String?
    @NSManaged public var deptTime: Date?
    @NSManaged public var arivalTime: String?
    @NSManaged public var travelsName: String?
    @NSManaged public var rating: Int16
    @NSManaged public var imageUrl: String?
    @NSManaged public var busTypeAc: Bool
    @NSManaged public var busTypeNonAc: Bool
    @NSManaged public var bustypeSl: Bool
    @NSManaged public var busTypeSeat: Bool
    
    @NSManaged public var busFair: Double
    @NSManaged public var currency:String?
}
