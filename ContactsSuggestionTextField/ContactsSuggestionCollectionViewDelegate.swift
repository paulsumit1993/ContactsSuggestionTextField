//
//  ContactsSuggestionCollectionViewDelegate.swift
//
//  Copyright © 2018 Sumit Paul. All rights reserved.
//

import Foundation

class ContactsSuggestionCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    let contacts: [SuggestedContact]
    let contactSelectedHandler: ((String) -> Void)?
    
    init(contacts: [SuggestedContact], selectionHandler: ((String) -> Void)?) {
        self.contacts = contacts
        self.contactSelectedHandler = selectionHandler
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let emailAddress = contacts[indexPath.row].emailAddress {
            contactSelectedHandler?(emailAddress)
            return
        }
        
        if let phoneNumber = contacts[indexPath.row].phoneNumber {
            contactSelectedHandler?(phoneNumber)
            return
        }
    }
}

// MARK:- UICollectionViewDelegateFlowLayout
extension ContactsSuggestionCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    /// Used for determing the width of the cell depending on the width of the longest string.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = contacts[indexPath.row].longestLength
        return CGSize(width: width + 40, height: AccessoryViewDimension.height)
    }
}
