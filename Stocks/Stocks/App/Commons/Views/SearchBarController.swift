//
//  SearchBarController.swift
//  Stocks
//
//  Created by Marlon David Ruiz Arroyave on 15/10/21.
//

import UIKit

protocol SearchBarControllerDelegate: AnyObject {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar)
    func textDidChange(searchText: String)
    func cancelButtonTapped()
}

protocol SearchBarProtocol: UISearchBarDelegate {
    var text: String? { get set }
    var isSearchBarEmpty: Bool { get }
    var isFiltering: Bool { get }
    var showsCancelButton: Bool { get set }
}

class SearchBarController: UISearchController, SearchBarProtocol {

    private weak var searchBarControllerDelegate: SearchBarControllerDelegate?

    var text: String? {
        get {
            searchBar.text
        }
        set {
            searchBar.text = newValue
        }
    }

    var isSearchBarEmpty: Bool {
      searchBar.text?.isEmpty ?? true
    }

    var isFiltering: Bool {
      isActive && !isSearchBarEmpty
    }

    var showsCancelButton: Bool = false {
        didSet {
            searchBar.showsCancelButton = showsCancelButton
        }
    }

    init(_ placeholder: String?, delegate: SearchBarControllerDelegate) {
        self.searchBarControllerDelegate = delegate
        super.init(searchResultsController: nil)
        self.obscuresBackgroundDuringPresentation = false
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        searchBar.placeholder = placeholder
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBarControllerDelegate?.searchBarTextDidBeginEditing(searchBar)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBarControllerDelegate?.searchBarTextDidEndEditing(searchBar)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarControllerDelegate?.textDidChange(searchText: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBarControllerDelegate?.cancelButtonTapped()
    }

}
