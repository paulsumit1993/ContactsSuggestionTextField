//
//  ContactsManager.swift
//
//  Copyright © 2018 Sumit Paul. All rights reserved.

import Contacts

/// Used to fetch and filter contacts from contact store.
/// Note: `NSContactsUsageDescription` must be set in `Info.plist` of the app before we access this class / library.

final class ContactsManager {
    
    private let contactStore: CNContactStore
    
    /// holds the set of parameters to be fetched while retrieving a CNContact from contact store.
    private var keys: [String]
    private var contactType: ContactType
    
    // Contacts cache
    private var allContacts = Set<SuggestedContact>()
    
    /// contact manager initializer.
    
    init(contactType: ContactType, nameStyle: ContactsNameStyle) {
        self.contactStore = CNContactStore()
        self.contactType = contactType
        var keys = [String]()
        
        switch contactType {
        case .emailAddress: keys.append(CNContactEmailAddressesKey)
        case .phoneNumber: keys.append(CNContactPhoneNumbersKey)
        }
        
        switch nameStyle {
        case .short: keys.append(CNContactGivenNameKey)
            
        case .medium: keys.append(contentsOf: [CNContactNamePrefixKey,
                                               CNContactGivenNameKey,
                                               CNContactMiddleNameKey,
                                               CNContactFamilyNameKey])
            
        case .long: keys.append(contentsOf: [CNContactNamePrefixKey,
                                             CNContactGivenNameKey,
                                             CNContactMiddleNameKey,
                                             CNContactFamilyNameKey,
                                             CNContactNameSuffixKey])
        }
        self.keys = keys
    }
    
    /// Used to seek permission from the user to access their contacts information.
    ///
    /// - Parameter completionHandler: which returns with permission status state and / or an error in case of a failure.
    
    /// Note: `NSContactsUsageDescription` must be set in `Info.plist` of the app before we access this method.
    func requestContactsAccess(completionHandler: @escaping (Bool, Error?) -> Void) {
        if ContactsManager.isContactsAccessAllowed {
            completionHandler(true, nil)
        }
        
        contactStore.requestAccess(for: .contacts) { (accessAllowed, error) in
            completionHandler(accessAllowed, error)
        }
    }
    
    /// Used to fetch contacts depending on a search string that the user inputs in the text field.
    ///
    /// - Parameters:
    ///   - searchString: Used to filter contacts.
    ///   - completion: called with a set of filter contacts.
    func fetchContacts(with searchString: String, completion: @escaping (Set<SuggestedContact>) -> Void) {
        
        var nameFilterArray = Set<SuggestedContact>()
        var contactTypeFilterArray = Set<SuggestedContact>()
        
        // retrieving the cached contacts
        if allContacts.count > 0 {
            
            switch contactType {
            case .phoneNumber:
                contactTypeFilterArray = allContacts.filter { contact in
                    guard let phoneNumber = contact.phoneNumber else { return false }
                    return phoneNumber.lowercased().contains(searchString.lowercased())
                }
            case .emailAddress:
                contactTypeFilterArray = allContacts.filter { contact in
                    guard let emailAddress = contact.emailAddress else { return false }
                    return emailAddress.lowercased().contains(searchString.lowercased())
                }
            }
            
            nameFilterArray = allContacts.filter { $0.fullName.lowercased().contains(searchString.lowercased()) }
            
            completion(nameFilterArray.union(contactTypeFilterArray))
            return
        }
        
        contactStore.requestAccess(for: .contacts) { [weak self] (accessAllowed, error) in
            if accessAllowed {
                guard let keys = self?.keys else { return }
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    try self?.contactStore.enumerateContacts(with: request) { (contact, stoppingPointer) in
                        let contact = SuggestedContact(cnContact: contact)
                        self?.allContacts.insert(contact)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    public static var isContactsAccessAllowed: Bool {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized: return true
        default: return false
        }
    }
    
    public static var isContactsAccessPermissionDetermined: Bool {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .notDetermined: return false
        default: return true
        }
    }
}
