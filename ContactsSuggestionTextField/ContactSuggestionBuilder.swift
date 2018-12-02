//
//  ContactSuggestionBuilder.swift
//
//  Copyright © 2018 Sumit Paul. All rights reserved.

import UIKit

/// Describes the formatting style of the full name that will be displayed to the user.
///
/// - short: includes the given / first name only if available.
/// - medium: is a combination of first / given, middle and last name based on availability.
/// - long: includes prefix, first / given, middle, last name and suffix depending on availability respectively.
public enum ContactsNameStyle {
    case short
    case medium
    case long
}

/// formatter which defines whether a user wants to pick an e-mail or a phone number.
public enum ContactType {
    case phoneNumber
    case emailAddress
}

/// Used for customising the input suggestion accessory view’s appearance and behaviour.
public class ContactCustomizationBuilder {
    public var contactNameStyle: ContactsNameStyle = .medium
    public var contactType: ContactType = .phoneNumber
}
