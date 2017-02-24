//
//  Contact.swift
//  Contacts
//
//  Created by Sterling Mortensen on 2/24/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import Foundation
import CloudKit

class Contact {
    
    private let nameKey = "name"
    private let phoneNumberKey = "phoneNumber"
    private let emailKey = "email"
    
    let name: String
    let phoneNumber: String
    let email: String
    
    init(name: String, phoneNumber: String, email: String) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
    }
    
    init?(cloudKitRecord: CKRecord) {
        guard let name = cloudKitRecord[nameKey] as? String,
            let phoneNumber = cloudKitRecord[phoneNumberKey] as? String,
            let email = cloudKitRecord[emailKey] as? String else { return nil }
        
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
    }
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: "Contact")
        record.setValue(name, forKey: nameKey)
        record.setValue(phoneNumber, forKey: phoneNumberKey)
        record.setValue(email, forKey: emailKey)
        return record
    }
    
    
}
