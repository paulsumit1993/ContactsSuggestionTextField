//
//  ContactsSuggestionInputAccessoryView.swift
//
//  Copyright © 2018 Sumit Paul. All rights reserved.

import UIKit

/// View that is assigned to a keyboard’s accessory view for showing the relevant contacts.
final class ContactsSuggestionInputAccessoryView: UIView {
    
    @IBOutlet weak private var backgroundVisualEffectView: UIVisualEffectView!
    @IBOutlet weak private var contactsCollectionView: UICollectionView!
    
    /// called when a user selects a particular contact from the list shown to the user.
    var contactSelectedHandler: ((String) -> Void)?
    
    /// holds keyboard appearance state for current textfield.
    private var backgroundAppearance: UIKeyboardAppearance = .light
    
    /// holds a list of filtered contacts.
    private var filteredArray = [SuggestedContact]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.contactsCollectionView.reloadSections([0])
            }
        }
    }
    
    private var contactsSuggestionCollectionViewDelegate: ContactsSuggestionCollectionViewDelegate?
    private var contactsSuggestionCollectionViewDatasource: ContactsSuggestionCollectionViewDatasource?
    
    private var contactsManager: ContactsManager?
    
    /// used to filter contacts.
    var filterText: String? {
        didSet {
            guard let filterText = filterText else {
                filteredArray.removeAll()
                return
            }
            
            contactsManager?.fetchContacts(with: filterText) { [weak self] contacts in
                self?.filteredArray = contacts.compactMap { $0 }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    /// Calls Contacts access request API if access is not determined.
    func requestContactAccessIfNeeded() {
        guard ContactsManager.isContactsAccessPermissionDetermined else {
            contactsManager?.requestContactsAccess { _,_ in }
            return
        }
    }
    
    private func setupCollectionView() {
        let cell = UINib(nibName: ContactsSuggestionInputAccessoryCell.className, bundle: Bundle(for: ContactsSuggestionInputAccessoryView.self))
        contactsCollectionView.register(cell, forCellWithReuseIdentifier: ContactsSuggestionInputAccessoryCell.className)
        contactsSuggestionCollectionViewDelegate = ContactsSuggestionCollectionViewDelegate(contacts: filteredArray, selectionHandler: contactSelectedHandler)
        contactsSuggestionCollectionViewDatasource = ContactsSuggestionCollectionViewDatasource(contacts: filteredArray, backgroundAppearance: backgroundAppearance)
        contactsCollectionView.delegate = contactsSuggestionCollectionViewDelegate
        contactsCollectionView.dataSource = contactsSuggestionCollectionViewDatasource
    }
    
    /// Used for customizing the accessory view.
    ///
    /// - Parameters:
    ///   - builder: contains the customization data points.
    ///   - keyboardAppearance: determines the appearance of the accessory view, light or dark.
    func configure(with builder: ContactCustomizationBuilder, keyboardAppearance: UIKeyboardAppearance) {
        backgroundAppearance = keyboardAppearance
        switch keyboardAppearance {
        case .light, .default:
            backgroundVisualEffectView.effect = UIBlurEffect(style: .prominent)
        case .dark:
            backgroundVisualEffectView.effect = UIBlurEffect(style: .dark)
        }
        contactsManager = ContactsManager(contactType: builder.contactType, nameStyle: builder.contactNameStyle)
    }
}
