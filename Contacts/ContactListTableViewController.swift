//
//  ContactListTableViewController.swift
//  Contacts
//
//  Created by Sterling Mortensen on 2/24/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import UIKit

class ContactListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            ContactController.shared.fetchAllRecords {
                self.tableView.reloadData()
            }
        }
    }
    
    func updateTableView() {
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableView), name: ContactController.shared.notificationOfChange, object: nil)

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactController.shared.contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactListCell", for: indexPath)
        
        let contact = ContactController.shared.contacts[indexPath.row]
        cell.textLabel?.text = contact.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = ContactController.shared.contacts[indexPath.row]
        ContactController.shared.fetchRecord(byContactName: contact) { 
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: ContactController.shared.notificationOfChange, object: self)
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailViewSegue", let indexPath = tableView.indexPathForSelectedRow {
            let contact = ContactController.shared.contacts[indexPath.row]
            guard let destination = segue.destination as? ContactDetailViewController else { return }
            destination.contact = contact
        }
    }
}
