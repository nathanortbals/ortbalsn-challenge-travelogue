//
//  Entry+CoreDataClass.swift
//  ortbalsn-challenge-travelogue
//
//  Created by Nathan Ortbals on 4/9/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

public class Entry: NSManagedObject {
    var date: Date? {
        get {
            return rawDate as Date?
        }
        set {
            rawDate = newValue as NSDate?
        }
    }
    
    var image: UIImage? {
        get {
            if let data = rawImage as Data? {
                return UIImage(data: data)
            }
            
            return nil
        }
        set(newImage) {
            if let newImage = newImage {
                if let data = newImage.pngData() as NSData? {
                    print(data.length)
                    rawImage = data
                }
            }
            else {
                rawImage = nil
            }
        }
    }
    
    convenience init?(title: String?, content: String?, image: UIImage?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        self.init(entity: Entry.entity(), insertInto: managedContext)
        
        self.title = title
        self.contant = content
        self.image = image
        self.date = Date()
    }
}
