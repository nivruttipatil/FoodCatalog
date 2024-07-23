//
//  FoodViewModel.swift
//  FoodCatalog
//
//  Created by Nivrutti on 23/07/24.
//

import Foundation

typealias messageHandler = (String) -> Void
typealias emptyHandler = () -> Void

protocol FoodViewModelProtocol {
    func getFoods()
    func searchFood(_ searchText: String)
    func loadFoodAsPerCategoryId(_ id: Int)
    func clearSearch()
    var getFoodsItems:[Food] {get}
    var getCategories:[FoodCategory] {get}
    var errorHandler: messageHandler { get set}
    var dataLoaded: emptyHandler { get set }
}
 
final class FoodViewModel: FoodViewModelProtocol {
    private var categories: [FoodCategory]?
    private var foods: [Food]?
    private var foodUserCase: GetFoodUseCaseProtocol
    private var selectedCategory:FoodCategory?
   
    var getFoodsItems: [Food] {
        foods ?? []
    }
    
    var getCategories: [FoodCategory] {
        categories ?? []
    }
    
    var errorHandler: messageHandler = {_ in }
    var dataLoaded: emptyHandler = {()}
    
    init(foodUserCase: GetFoodUseCaseProtocol) {
        self.foodUserCase = foodUserCase
    }
}

extension FoodViewModel {
    
    func getFoods() {
        switch foodUserCase.execute() {
        case .success(let categoriesResponse):
            categories = categoriesResponse?.categories
            selectedCategory = categories?.first
            refreshFoods()
        case .failure(let error):
            errorHandler(error.errorDescription)
        }
    }
    
    func searchFood(_ searchText: String) {
        if searchText.isEmpty {
            refreshFoods(isSearching: true)
        } else {
            foods = selectedCategory?.foods?.filter { model in
                return model.name?.lowercased().range(of: searchText.lowercased()) != nil
            }
            updateHandler(isSearching: true)
        }
    }
    
    func loadFoodAsPerCategoryId(_ id: Int) {
        selectedCategory = categories?.filter({$0.id == id}).first
        refreshFoods()
    }
    
    func clearSearch(){
        refreshFoods()
    }
    
    private func refreshFoods(isSearching: Bool = false) {
        foods = selectedCategory?.foods
        updateHandler(isSearching: isSearching)
    }
    
    private func updateHandler(isSearching: Bool = false) {
        if foods?.isEmpty ?? true {
            if isSearching {
                errorHandler(FoodScreenConstant.Error.noSearchMatch)
            } else {
                errorHandler(FoodScreenConstant.Error.noSearchMatch)
            }
        } else {
            dataLoaded()
        }
    }
}

