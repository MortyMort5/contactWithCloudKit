//
//  ContactDetailViewController.swift
//  Contacts
//
//  Created by Sterling Mortensen on 2/24/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    //==============================================================
    // MARK: - Properties
    //==============================================================
    var contact: Contact?
    
    //==============================================================
    // MARK: - Outlets
    //==============================================================
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    //==============================================================
    // MARK: - IBActions
    //==============================================================
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, let phoneNumber = phoneNumberTextField.text, let email = emailTextField.text else { return }
        
        let contactObject = Contact(name: name, phoneNumber: phoneNumber, email: email)
        
        ContactController.shared.saveContactInfoWith(contact: contactObject) { 
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: ContactController.shared.notificationOfChange, object: self)
            }
        }
        self.contact = contactObject
        let _ = self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateViews), name: ContactController.shared.notificationOfChange, object: nil)
    }
    
    func updateViews() {
        guard let contact = contact else { return }
        nameTextField.text = contact.name
        phoneNumberTextField.text = contact.phoneNumber
        emailTextField.text = contact.email
    }
    
}
