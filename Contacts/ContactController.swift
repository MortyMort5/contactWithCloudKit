//
//  ContactController.swift
//  Contacts
//
//  Created by Sterling Mortensen on 2/24/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import Foundation
import CloudKit

class ContactController {
    
    static let shared = ContactController()
    let publicDatabase = CKContainer.default().publicCloudDatabase
    let notificationOfChange = Notification.Name("ContactDidChange")
    var contacts: [Contact] = [] {
        didSet {
            NotificationCenter.default.post(name: notificationOfChange, object: self)
        }
    }
    
    func saveContactInfoWith(contact: Contact, completion: @escaping() -> Void) {
        
        let contactRecord = contact.cloudKitRecord
        
        publicDatabase.save(contactRecord) { (_, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.contacts.append(contact)
            }
        }
    }
    
    func fetchAllRecords(completion: @escaping() -> Void) {
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "Contact", predicate: predicate)
        
        publicDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let records = records else { return }
                let contacts = records.flatMap({ Contact(cloudKitRecord: $0) })
                self.contacts = contacts
                completion()
            }
        }
    }
    
    func fetchRecord(byContactName contact: Contact, completion: @escaping() -> Void) {
        
        
        let predicate = NSPredicate(format: "name == %@", contact.name)
        
        let query = CKQuery(recordType: "Contact", predicate: predicate)
        
        publicDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let records = records else { return }
                let contacts = records.flatMap({ Contact(cloudKitRecord: $0) })
                self.contacts = contacts
                completion()
            }
        }
    }
    
    
}
