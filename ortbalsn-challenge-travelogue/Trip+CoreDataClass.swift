//
//  Trip+CoreDataClass.swift
//  ortbalsn-challenge-travelogue
//
//  Created by Nathan Ortbals on 4/9/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

public class Trip: NSManagedObject {
    var entries: [Entry]? {
        return self.rawEntries?.allObjects as? [Entry]
    }
    
    convenience init?(title: String?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        self.init(entity: Trip.entity(), insertInto: managedContext)
        
        self.title = title
    }
}
