
import UIKit

/// Describes the formatting style of the full name that will be displayed to the user.
public enum ContactsNameStyle {
    /// Includes the given / first name only if available.
    case short
    /// A combination of first / given, middle and last name based on availability.
    case medium
    /// Includes prefix, first / given, middle, last name and suffix depending on availability respectively.
    case long
}

/// formatter which defines whether a user wants to pick an e-mail or a phone number.
public enum ContactType {
    /// Phone Number.
    case phoneNumber
    /// E-mail address.
    case emailAddress
}

/// Used for customising the input suggestion accessory view’s appearance and behaviour.
public class ContactCustomizationBuilder {
    /// `ContactsNameStyle` property.
    public var contactNameStyle: ContactsNameStyle = .medium
    /// `ContactTypes` property.
    public var contactType: ContactType = .phoneNumber
}
