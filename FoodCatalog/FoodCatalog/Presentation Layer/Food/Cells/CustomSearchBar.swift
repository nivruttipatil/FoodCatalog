//
//  CustomSearchBar.swift
//  FoodCatalog
//
//  Created by Nivrutti on 23/07/24.
//

import UIKit

protocol CustomSearchBarDelegate {
    func searchBarTextDidChange(_ searchText: String)
    func searchBarCancelButtonClicked()
}

class CustomSearchBar: UISearchBar {
   
    var searchDelegate: CustomSearchBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        barTintColor = FoodScreenTheme.Color.black
        let color = FoodScreenTheme.Color.black
        searchTextField.textColor = FoodScreenTheme.Color.black
        searchTextField.font = FoodScreenTheme.Font.body
        searchTextField.attributedPlaceholder =  NSAttributedString.init(string: FoodScreenConstant.Error.searchPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: color])
        searchTextField.backgroundColor = FoodScreenTheme.Color.white
        searchTextField.leftView?.tintColor = color
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([.foregroundColor: FoodScreenTheme.Color.white], for: .normal)
        delegate = self
    }
    
    func clearSearch() {
        showsCancelButton = false
        text = ""
        self.resignFirstResponder()
    }
}

extension CustomSearchBar : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchDelegate?.searchBarTextDidChange(searchText)
        searchBar.showsCancelButton = !searchText.isEmpty
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearSearch()
        searchDelegate?.searchBarCancelButtonClicked()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        self.resignFirstResponder()
    }
}

