//
//  ContactsTableViewController.swift
//  Task3
//
//  Created by Tester on 10/22/18.
//  Copyright © 2018 aaa. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    let networkController = NetworkController()
    var contacts = [Contact]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadContacts()
    }
    
    private func loadContacts() {
        networkController.loadContacts { results in
            if let results = results {
                self.contacts = results
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        if let contactCell = cell as? ContactTableViewCell {
            contactCell.contact = contacts[indexPath.row]
        }
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContactSegue" {
            guard
                let senderCell = sender as? ContactTableViewCell,
                let destination = segue.destination as? ContactViewController
                else {
                    print("ERROR")
                    return
            }
            destination.contact = senderCell.contact
            destination.networkController = networkController
        }
    }
    
}
