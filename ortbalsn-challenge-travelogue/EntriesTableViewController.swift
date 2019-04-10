//
//  EntriesTableViewController.swift
//  ortbalsn-challenge-travelogue
//
//  Created by Nathan Ortbals on 4/9/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {

    var trip: Trip!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func deleteEntry(at indexPath: IndexPath) {
        if let entry = trip.entries?[indexPath.row], let managedContext = entry.managedObjectContext {
            managedContext.delete(entry)
            
            do {
                try managedContext.save()
                trip.removeFromRawEntries(entry)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                
            } catch{
                print("Could not delete entry")
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trip?.entries?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        if let entry = trip.entries?[indexPath.row], let cell = cell as? EntryTableViewCell {
            cell.setLabels(entry: entry)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EntryViewController {
            destination.trip = trip
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedRow = indexPath.row
                destination.existingEntry = trip.entries?[selectedRow]
            }
            else {
                destination.existingEntry = nil
            }
        }
    }
}

class EntryTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    func setLabels(entry: Entry) {
        titleLabel.text = entry.title
    }
}
