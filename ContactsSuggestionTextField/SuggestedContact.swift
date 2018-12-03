//
//  SuggestedContact.swift
//
//  Copyright © 2018 Sumit Paul. All rights reserved.

import Contacts

/// Model which holds contacts data and can be instantiated from a CNContact.
struct SuggestedContact: Hashable {
    private var namePrefix: String = ""
    private var givenName: String = ""
    private var middleName: String = ""
    private var familyName: String = ""
    private var nameSuffix: String = ""
    var emailAddress: String?
    var phoneNumber: String?
    var fullName: String {
        var nameComponents = PersonNameComponents()
        let personNameFormatter = PersonNameComponentsFormatter()
        nameComponents.namePrefix = namePrefix
        nameComponents.givenName = givenName
        nameComponents.middleName = middleName
        nameComponents.familyName = familyName
        nameComponents.nameSuffix = nameSuffix
        return personNameFormatter.string(from: nameComponents)
    }
    
    init(cnContact: CNContact) {
        self.givenName = cnContact.givenName
        
        if cnContact.isKeyAvailable(CNContactNamePrefixKey) {
            self.namePrefix = cnContact.namePrefix
        }
        
        if cnContact.isKeyAvailable(CNContactMiddleNameKey) {
            self.middleName = cnContact.middleName
        }
        
        if cnContact.isKeyAvailable(CNContactFamilyNameKey) {
            self.familyName = cnContact.familyName
        }
        
        if cnContact.isKeyAvailable(CNContactNameSuffixKey) {
            self.nameSuffix = cnContact.nameSuffix
        }
        
        if cnContact.isKeyAvailable(CNContactEmailAddressesKey) {
            self.emailAddress = cnContact.emailAddresses.first?.value as String?
        }
        if cnContact.isKeyAvailable(CNContactPhoneNumbersKey) {
            self.phoneNumber = cnContact.phoneNumbers.first?.value.stringValue
        }
    }
    
    private var fullNameWidth: CGFloat {
        return fullName.width(withConstrainedHeight: AccessoryViewDimension.height, font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.styleForDevice))
    }

    private var emailAddressWidth: CGFloat {
        return emailAddress?.width(withConstrainedHeight: AccessoryViewDimension.height, font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.styleForDevice)) ?? 0.0
    }

    private var phoneNumberWidth: CGFloat {
        return phoneNumber?.width(withConstrainedHeight: AccessoryViewDimension.height, font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.styleForDevice)) ?? 0.0
    }
    
    var longestLength: CGFloat {
        return max(max(fullNameWidth, emailAddressWidth), phoneNumberWidth)
    }
}
