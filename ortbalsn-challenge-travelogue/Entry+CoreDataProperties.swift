//
//  Entry+CoreDataProperties.swift
//  ortbalsn-challenge-travelogue
//
//  Created by Nathan Ortbals on 4/9/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var contant: String?
    @NSManaged public var rawDate: NSDate?
    @NSManaged public var rawImage: NSData?
    @NSManaged public var title: String?
    @NSManaged public var trip: Trip?

}
