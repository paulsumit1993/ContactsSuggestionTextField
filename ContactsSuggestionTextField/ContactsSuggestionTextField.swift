//
//  ContactsSuggestionTextField.swift
//
//  Copyright © 2018 Sumit Paul. All rights reserved.

import UIKit

/// Custom Textfield used for attaching a custom accessory view acting as a contacts picker to the keyboard's input accessory view.
/// - Note: NSContactsUsageDescription should be set in Info.plist of the app for the UITextfield subclass to work as this subclass accesses contacts data.
public final class ContactsSuggestionTextField: UITextField {
    
    /// custom accessory view
    private var contactsAccessoryView: ContactsSuggestionInputAccessoryView?
    
    /// block called when a user selects a contact in the accessory view, returns a string version of e-mail / phone number.
    public var contactSelectedHandler: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSuggestionsView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSuggestionsView()
    }
    
    private func setupSuggestionsView(with builder: ContactCustomizationBuilder = ContactCustomizationBuilder()) {
        contactsAccessoryView = Bundle(for: ContactsSuggestionTextField.self).loadNibNamed(ContactsSuggestionInputAccessoryView.className, owner: nil, options: nil)?.first as? ContactsSuggestionInputAccessoryView
        contactsAccessoryView?.frame = contactsAccessoryView?.accessoryViewFrame ?? CGRect.zero
        contactsAccessoryView?.configure(with: builder, keyboardAppearance: keyboardAppearance)
        self.addTarget(self, action: #selector(didBeginEditing), for: UIControl.Event.editingDidBegin)
        self.addTarget(self, action: #selector(editingChanged), for: UIControl.Event.editingChanged)
        contactsAccessoryView?.contactSelectedHandler = { [weak self] email in
            self?.filterContacts(with: nil)
            self?.hideContactsAccessoryView()
            self?.contactSelectedHandler?(email)
        }
    }
    
    /// Utitized to customise the accessory view’s appearance.
    ///
    /// - Parameter block: customization closure.
    public func customize(block: (ContactCustomizationBuilder) -> Void) {
        let builder = ContactCustomizationBuilder()
        block(builder)
        setupSuggestionsView(with: builder)
    }
    
    /// Used to filter results based on user input in the particular textfield.
    ///
    /// - Parameter filterString: the string that should be used to filter results.
    private func filterContacts(with filterString: String?) {
        guard ContactsManager.isContactsAccessAllowed else { return }
        contactsAccessoryView?.filterText = filterString
    }
    
    /// Presents the accessory view on the keyboard.
    private func showContactsAccessoryView() {
        guard ContactsManager.isContactsAccessAllowed else { return }
        guard self.inputAccessoryView == nil else { return }
        self.inputAccessoryView = contactsAccessoryView
        self.reloadInputViews()
    }
    
    /// Used to request Contacts permission access.
    private func requestContactAccessIfNeeded() {
        contactsAccessoryView?.requestContactAccessIfNeeded()
    }
    
    /// Hides the accessory view.
    private func hideContactsAccessoryView() {
        self.inputAccessoryView = nil
        self.reloadInputViews()
    }
    
    @objc private func didBeginEditing() {
        self.requestContactAccessIfNeeded()
    }
    
    @objc private func editingChanged() {
        self.showContactsAccessoryView()
        self.filterContacts(with: text)
    }
}
