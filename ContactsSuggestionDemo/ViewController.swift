//
//  ViewController.swift
//  ContactsSuggestionDemo
//
//  Copyright © 2018 Sumit Paul. All rights reserved.
//

import UIKit
import ContactsSuggestionTextField

class ViewController: UIViewController {
    @IBOutlet weak var contactsSuggestionTextfield: ContactsSuggestionTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsSuggestionTextfield.customize { builder in
            builder.contactNameStyle = .long
            builder.contactType = .emailAddress
        }
        
        contactsSuggestionTextfield.contactSelectedHandler = { [weak self] contact in
            self?.contactsSuggestionTextfield.text = contact
        }
    }


}

