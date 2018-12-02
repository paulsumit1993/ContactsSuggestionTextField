//
//  ContactsSuggestionInputAccessoryCell.swift
//
//  Copyright © 2018 Sumit Paul. All rights reserved.

import UIKit

/// cell which displays the contacts.
final class ContactsSuggestionInputAccessoryCell: UICollectionViewCell {
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var subTitleLabel: UILabel!
    
    /// called to configure the cell with relevant data.
    ///
    /// - Parameters:
    ///   - contact: contact to be displayed in the cell.
    ///   - backgroundStyle: the background theme, light or dark.
    func configure(with contact: SuggestedContact, backgroundStyle: UIKeyboardAppearance) {
        titleLabel.text = contact.fullName
        
        if let phoneNumber = contact.phoneNumber {
            subTitleLabel.text = phoneNumber
        }
        
        if let emailAddress = contact.emailAddress {
            subTitleLabel.text = emailAddress
        }
        
        switch backgroundStyle {
        case .light, .default:
            titleLabel.textColor = .black
            subTitleLabel.textColor = .black
        case .dark:
            titleLabel.textColor = .white
            subTitleLabel.textColor = .white
        }
    }
}
