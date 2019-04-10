//
//  NewTripViewController.swift
//  ortbalsn-challenge-travelogue
//
//  Created by Nathan Ortbals on 4/9/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import UIKit

class NewTripViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveTrip(_ sender: Any) {
        let title = titleTextField.text
        
        let trip = Trip(title: title)
        
        if let trip = trip {
            do {
                let managedContext = trip.managedObjectContext
                try managedContext?.save()
                
                self.navigationController?.popViewController(animated: true)
            } catch{
                print("Trip not saved")
            }
        }
    }
}
