//
//  TripsTableViewController.swift
//  ortbalsn-challenge-travelogue
//
//  Created by Nathan Ortbals on 4/9/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import UIKit
import CoreData

class TripsTableViewController: UITableViewController {
    
    var trips = [Trip]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
        
        do {
            trips = try managedContext.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            print("Could not fetch trips")
        }
    }
    
    func deleteCategory(at indexPath: IndexPath) {
        let dialogMessage = UIAlertController(title: "Confirm Delete", message: "This will delete all the trip's entries", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            let trip = self.trips[indexPath.row]
            
            if let managedContext = trip.managedObjectContext {
                managedContext.delete(trip)
                
                do {
                    try managedContext.save()
                    self.trips.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    
                } catch{
                    print("Could not delete trip")
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
        });
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }

        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            deleteCategory(at: indexPath)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return trips.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)
        let trip = trips[indexPath.row]
        
        if let cell = cell as? TripTableViewCell {
            cell.setLabels(trip: trip)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EntriesTableViewController {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedRow = indexPath.row
                destination.trip = self.trips[selectedRow]
            }
        }
    }
}

class TripTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numEntriesLabel: UILabel!
    
    func setLabels(trip: Trip) {
        titleLabel.text = trip.title
        
        if let count = trip.entries?.count {
            numEntriesLabel.text = String(count) + " Entries"
        }
        else {
            numEntriesLabel.text = "0 Entries"
        }
    }
}
