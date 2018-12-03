//
//  ContactsSuggestionCollectionViewDatasource.swift
//
//  Copyright © 2018 Sumit Paul. All rights reserved.
//

import Foundation

class ContactsSuggestionCollectionViewDatasource: NSObject, UICollectionViewDataSource {
    let contacts: [SuggestedContact]
    let backgroundAppearance: UIKeyboardAppearance
    
    init(contacts: [SuggestedContact], backgroundAppearance: UIKeyboardAppearance) {
        self.contacts = contacts
        self.backgroundAppearance = backgroundAppearance
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactsSuggestionInputAccessoryCell.className, for: indexPath) as? ContactsSuggestionInputAccessoryCell else { fatalError() }
        cell.configure(with: contacts[indexPath.row], backgroundStyle: backgroundAppearance)
        return cell
    }
}
